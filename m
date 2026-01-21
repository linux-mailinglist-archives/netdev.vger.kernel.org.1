Return-Path: <netdev+bounces-251969-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAnIOd4JcWmPcQAAu9opvQ
	(envelope-from <netdev+bounces-251969-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 18:16:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 558065A63C
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 18:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 56EC4B07B74
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FAA4949E6;
	Wed, 21 Jan 2026 15:56:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C61748C8A7
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 15:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769010991; cv=none; b=BJfEeJ6zeXVxRKK++xEj1713mHUdBZrGemBLinNbGOMDxWDAAIEl4t2acdq5ZEBstMhhSrNGZG8rridyW3aqQiVngZDvqbzVH8ZtolxfdkhcnwWjeRJ290m1rlCFZB1wsTGZWf04Oe0snhrmpUZFjc6YvjSE8RbRzCrPCgyrGHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769010991; c=relaxed/simple;
	bh=xqDRg42cn9s+PQJV3QJKXzwsDuQzgQ88O7+U4GmtgGA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qCU9C+/SQvBFUwkkFi7u98gVppIcNankwjcfvXnNTszzlpEkXmz79kGEhAf4e72abw8LMZWmvh/r0pynIpdZCxO8Iw5R7/nxMoliu12WzTL8Agvpg0AFbGiq26vDsl7a5u5AVvvBrxvv82+BQ1dGBDy0xObumVRviasWRGMeeT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-4058fd4666eso9233fac.3
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 07:56:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769010987; x=1769615787;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yFPLZuBBqgdNTKRLDjxt0gL81wNcNDScS38n9r2rPKI=;
        b=iN+GCFjEmHZaHnta+RMv8hvZgfo2oBANFL6/wi00c+j4XxPSlFDEtYGdR8ZtwWLt+Y
         uXtB8LpqzxCnsWbI1AoKVIs+ibouGInQqsa+Z5NSQVYMe0IhFBTR9IZKiedZqGTabztZ
         i4LH4Qk5gn/5N0qQnWb73npQDk3RmP1+7V1RO9yUSzFFnE4ZfeVKd2mgUALpNekY8+5y
         gIUa29+9YEVjcGq3uwhXHTAALstR7EGoVjamzNFKvxmvQw+nksyJORTu7TYGR8zha2ar
         iocN8inuyjnmBWROxyCEmx36eVjm7mHYKPYHafd/rLR5mFgAaHag9BmJT7LWdWtc+oHD
         EDLA==
X-Gm-Message-State: AOJu0Yx624VaAV4i1o38oLgYQXc6NpX3iSYV8B1MhSynVsBWmEqvn0X7
	2me/iRSkkVzxZ6GhzpqXMgKgGaj+Ap9w5R4gXX4kO0R/Znj6SxPVL8NL
X-Gm-Gg: AZuq6aK02siwkmUJcUWm8QGRsIH5FVQ4QORVJ8C2YXqc0s7xNBMzz/pxM0r5NmkUu40
	7dPEIqbKPqzJQqjHkD1HwV59HENzq/GBqtVRTXqp1m7ZAkPNgGMONBt1F2TLT3YAUICpkKl4EjK
	9zS0/6L96Uog28XtfLqo1Xrijr2Z0wr7wj0rVsvQO9Q96/d11dPTJ28JVGNpe6831QciHOtNpka
	tUbT831T7yl8Ur4vexvnhfGejana3Soz4sH9ifE+8wplFk2X3tUazFRln2o8IKZJ9dteawvv+vG
	Oa/Yx/stMMMLTzbYl0HRPfCKlyT8Aegct3JnMj3Xj3a5lAqryU6vilH9QqiMxwgpfJA/4bRnumE
	qPPABp36fKeuLaYlju5W663rJsLJa4BMAS/Qq1mfqTd8waT86O1gGrEHhQe1UGU1ZvfND8FPxrq
	fF8g==
X-Received: by 2002:a05:6870:b0f0:b0:404:406d:97f0 with SMTP id 586e51a60fabf-4044cfd0fe0mr8580116fac.29.1769010987141;
        Wed, 21 Jan 2026 07:56:27 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:74::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4044bd150dasm11715344fac.14.2026.01.21.07.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 07:56:26 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 21 Jan 2026 07:54:44 -0800
Subject: [PATCH net-next 7/9] net: sfc: efx: convert to use
 .get_rx_ring_count
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-grxring_big_v4-v1-7-07655be56bcf@debian.org>
References: <20260121-grxring_big_v4-v1-0-07655be56bcf@debian.org>
In-Reply-To: <20260121-grxring_big_v4-v1-0-07655be56bcf@debian.org>
To: Ajit Khaparde <ajit.khaparde@broadcom.com>, 
 Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>, 
 Somnath Kotur <somnath.kotur@broadcom.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Igor Russkikh <irusskikh@marvell.com>, Simon Horman <horms@kernel.org>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
 Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
 Edward Cree <ecree.xilinx@gmail.com>, Brett Creeley <brett.creeley@amd.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 oss-drivers@corigine.com, linux-hyperv@vger.kernel.org, 
 linux-net-drivers@amd.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=3292; i=leitao@debian.org;
 h=from:subject:message-id; bh=xqDRg42cn9s+PQJV3QJKXzwsDuQzgQ88O7+U4GmtgGA=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpcPciRWUko2VZt6F/WLprp19CaDmdxXd8gCTmr
 AmzhFwNFtWJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaXD3IgAKCRA1o5Of/Hh3
 beweD/wJr1aUPxdEVvGudYkpHRXkoauHiVaUAquCOEQS5q7dCw6OoY+ZwsfHls/avBc8uTZgItZ
 XGWoLFa2DsgWkHzOXdGqUmAsPTQMDkDiddYSTAOn1BwZmN6VcOg3VAP7nmwSrT/WDjR72I+BalU
 DUKINlJbkdNlGYd6vZbe7ZoV3QvFLU8BKDXM6d6XYg5LYvYvgozFXKnzTBLGvubC2DFyAjmn9x2
 2F1nHN/n0l2g0xXxcM028KJH8bEc8wp1txT9jmaC4cJHf7+P2yW9aJsKw6HHQoq184e/KF0ftKg
 OVWhhdcBnrio2QK+EphKSfwgEALRKfW4mFwk3y9nH8lEaVJay3bilCnLC+c/S3sj4sA6UrNXREw
 p1WPnaISpR7sS5fY4VFDpJg3F2f7/w8LdlkIvF4kf+Pgz1bqA78dYYVQUCDVIyHdLC66S8mMej+
 05uazO47nnZajuunxq3DremWh5C07PUU6t/vfBErzkjZJvUGulOGaPy3s4/ySr4LXn9fvg+JpFX
 nixOd1Icr4TDir+wVlrKDmbfuL1nzHNabNV7gb+Gp0RA8a7G64t/oK8wGTzOrKosBfsYGYfsiTM
 C8QpWeLAEpvS6DiuErtvWC7YXs4A9QGCJvh2hYMb9+LksxWV5oKlTDGOnZrEZd/tfEPUnzd03C/
 Drv7vNcmKTyq5ug==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Spamd-Result: default: False [0.24 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,marvell.com,microsoft.com,fb.com,meta.com,gmail.com,amd.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251969-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 558065A63C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use the newly introduced .get_rx_ring_count ethtool ops callback instead
of handling ETHTOOL_GRXRINGS directly in .get_rxnfc().

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/sfc/ef100_ethtool.c  |  1 +
 drivers/net/ethernet/sfc/ethtool.c        |  1 +
 drivers/net/ethernet/sfc/ethtool_common.c | 11 +++++++----
 drivers/net/ethernet/sfc/ethtool_common.h |  1 +
 4 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/sfc/ef100_ethtool.c b/drivers/net/ethernet/sfc/ef100_ethtool.c
index 6c3b74000d3b6..05dc7b10c8855 100644
--- a/drivers/net/ethernet/sfc/ef100_ethtool.c
+++ b/drivers/net/ethernet/sfc/ef100_ethtool.c
@@ -54,6 +54,7 @@ const struct ethtool_ops ef100_ethtool_ops = {
 	.get_ethtool_stats	= efx_ethtool_get_stats,
 	.get_rxnfc              = efx_ethtool_get_rxnfc,
 	.set_rxnfc              = efx_ethtool_set_rxnfc,
+	.get_rx_ring_count	= efx_ethtool_get_rx_ring_count,
 	.reset                  = efx_ethtool_reset,
 
 	.get_rxfh_indir_size	= efx_ethtool_get_rxfh_indir_size,
diff --git a/drivers/net/ethernet/sfc/ethtool.c b/drivers/net/ethernet/sfc/ethtool.c
index 18fe5850a9786..362388754a292 100644
--- a/drivers/net/ethernet/sfc/ethtool.c
+++ b/drivers/net/ethernet/sfc/ethtool.c
@@ -261,6 +261,7 @@ const struct ethtool_ops efx_ethtool_ops = {
 	.reset			= efx_ethtool_reset,
 	.get_rxnfc		= efx_ethtool_get_rxnfc,
 	.set_rxnfc		= efx_ethtool_set_rxnfc,
+	.get_rx_ring_count	= efx_ethtool_get_rx_ring_count,
 	.get_rxfh_indir_size	= efx_ethtool_get_rxfh_indir_size,
 	.get_rxfh_key_size	= efx_ethtool_get_rxfh_key_size,
 	.rxfh_per_ctx_fields	= true,
diff --git a/drivers/net/ethernet/sfc/ethtool_common.c b/drivers/net/ethernet/sfc/ethtool_common.c
index fa303e171d98b..2fc42b1a2bfb7 100644
--- a/drivers/net/ethernet/sfc/ethtool_common.c
+++ b/drivers/net/ethernet/sfc/ethtool_common.c
@@ -850,6 +850,13 @@ int efx_ethtool_get_rxfh_fields(struct net_device *net_dev,
 	return rc;
 }
 
+u32 efx_ethtool_get_rx_ring_count(struct net_device *net_dev)
+{
+	struct efx_nic *efx = efx_netdev_priv(net_dev);
+
+	return efx->n_rx_channels;
+}
+
 int efx_ethtool_get_rxnfc(struct net_device *net_dev,
 			  struct ethtool_rxnfc *info, u32 *rule_locs)
 {
@@ -858,10 +865,6 @@ int efx_ethtool_get_rxnfc(struct net_device *net_dev,
 	s32 rc = 0;
 
 	switch (info->cmd) {
-	case ETHTOOL_GRXRINGS:
-		info->data = efx->n_rx_channels;
-		return 0;
-
 	case ETHTOOL_GRXCLSRLCNT:
 		info->data = efx_filter_get_rx_id_limit(efx);
 		if (info->data == 0)
diff --git a/drivers/net/ethernet/sfc/ethtool_common.h b/drivers/net/ethernet/sfc/ethtool_common.h
index 24db4fccbe78a..f96db42534546 100644
--- a/drivers/net/ethernet/sfc/ethtool_common.h
+++ b/drivers/net/ethernet/sfc/ethtool_common.h
@@ -40,6 +40,7 @@ int efx_ethtool_set_fecparam(struct net_device *net_dev,
 			     struct ethtool_fecparam *fecparam);
 int efx_ethtool_get_rxnfc(struct net_device *net_dev,
 			  struct ethtool_rxnfc *info, u32 *rule_locs);
+u32 efx_ethtool_get_rx_ring_count(struct net_device *net_dev);
 int efx_ethtool_set_rxnfc(struct net_device *net_dev,
 			  struct ethtool_rxnfc *info);
 u32 efx_ethtool_get_rxfh_indir_size(struct net_device *net_dev);

-- 
2.47.3



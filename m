Return-Path: <netdev+bounces-240832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F3CC7AFE9
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 18:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 89A9E382047
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 17:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69AC8352FA0;
	Fri, 21 Nov 2025 17:02:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CB9351FA5
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 17:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763744570; cv=none; b=h6mRQgPtM+4lSUvVwYRgMrPLKQifZI09lHsPqxsP77hkDoJo5WCsxOSY4SRNnawUCpDJiX3oP5lWelHbIgi539Iv/S1FUtTzvZUS6hM6QCtH8ZAOIxv9b80/snr8yhl3tnsLkm7HN2C9NOuHLt0Z8H03rmMzx46v64/uoKr4M6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763744570; c=relaxed/simple;
	bh=XF93bhl71hsuF18ZYsVmWcvRHzSNIMnpweA016vU9qg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RHyDfpiiwKjM++/lJL4FZ44ANu22HMYacfbARwxAGk/KVyvt3izHXLwgJ5YFBfs8msCj1vs0TbCQ2YqohlwaJUAX+F5B5K9S92vRTx/P5MTyYmG9hjiFQiPP09y4qvtWL7YQYCoxz0eTDWNtmSGmLeiWQhv6zwRBCzh1JboV86o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7c75fd8067fso1265922a34.2
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 09:02:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763744566; x=1764349366;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QBMGNHlPCrE6F/5h4n23j+Tr/lWB3KZnRoWf+L2l9xE=;
        b=OK2Jf3LsByYWohKiXrn0IzaTqccirPhBiYWpYaSUg/LfvJktHPU+JkhU6JxaptczsD
         IAAWamF9F5EpQpoY3dLa5PZgTPg9jrZe5Qdq7SBmSG2XP8fqjiWfogkQRXGAPy2UoERe
         EIE93n8qsdMwrNZb0jDGyD4evwy54UYB5QsE6A+CuTR4X25URAIAM/6G+F3+4zy4sMbQ
         5EHGsbIk6zDCSxDtekSZtRm3eTgNGtgwiFm9vM+3HiOFUIWwBH0StPTfb/F4OdUWoNAJ
         jNv1omafAxU+LRv9Micgc/Vg5Xe/UfyYAZNNY9Fmfd7V+9u/eunvTqAhVZMP95Q10m0O
         3EJg==
X-Gm-Message-State: AOJu0Ywgt3vO8rDgVSuTtToDJbaxePwj0nahY2WhspzR3mnq2msPBbKX
	Ngtc/iUK//oGU4R6Ihrpe8+6UmTOtiOD+kaRreqMTpoAJFG7pLHvWgxq
X-Gm-Gg: ASbGncvRHtR2I3o3YJ2R9Nzv5mpTEnYs2DiaD9QfrpLUZ0J5gM4G2AjDWXIu6kXzVLf
	0FhL6M1orfrgZ7sbZfQdFCCTi09n+RlCzcklVWRusfP4ryRp/R5aYcGTEFcpm7ZXUUoJGA3szvX
	MRe5PI/ILp1O1uL1cTxZj3PA/G9cVbnEFI6vestAdabiWTMGvsORVPszgGUCqpdCwsNmLfEBl+f
	heHet1jC/lQPB01QiCETiSTiNmcVFeuCxOLdWKs/p7e5bLSBTJXxPgmLvdGZwXHcLxzihgztNV+
	ku/zLEqIkxJjw3bWUt6zCnelFbRRiapiIWnqGYEbCRsIOIMc4jdx9oDo++HW1AZ0sJ5zh9qk2cg
	OXIx31//6gjCGj8vlm/qWx7GwKyw4ihkyjU3Pq6TXIgikko1m8bSeMLkfgtXYJwluSWg5p5zN+z
	lqgpwvk80VAhf/qA==
X-Google-Smtp-Source: AGHT+IGFlWod/7UHOmXZrbtbGiqn/1bAOycgTeQqjLFgqyLFih1hCaBR4MWaMjlJaZWhS8tDyQF6bg==
X-Received: by 2002:a05:6808:3099:b0:450:bc7e:85f4 with SMTP id 5614622812f47-4511291f137mr1332446b6e.5.1763744565918;
        Fri, 21 Nov 2025 09:02:45 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:40::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3eca814da76sm2316596fac.1.2025.11.21.09.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 09:02:45 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 21 Nov 2025 09:02:36 -0800
Subject: [PATCH net-next 2/2] net: mvpp2: extract GRXRINGS from .get_rxnfc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-marvell-v1-2-8338f3e55a4c@debian.org>
References: <20251121-marvell-v1-0-8338f3e55a4c@debian.org>
In-Reply-To: <20251121-marvell-v1-0-8338f3e55a4c@debian.org>
To: Marcin Wojtas <marcin.s.wojtas@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2110; i=leitao@debian.org;
 h=from:subject:message-id; bh=XF93bhl71hsuF18ZYsVmWcvRHzSNIMnpweA016vU9qg=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpIJsymGMfrQRjvOKIZHVu8dIzupCC8qpL2YtsM
 /UenPVVPXGJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaSCbMgAKCRA1o5Of/Hh3
 baNnEACQ8szUMDRCIdA3P3ph4FDxlK8pbCVgXzUNg9wPrqEC8XxOAtBkJkKltkjr9XbB/3fmhB3
 AKWQRTVnx+ZldCNWMalzI9eRwAhdp7Twa1FOqq/t0dMb7Sbq5nunXd5sSOBHlac1zRT7zzwwDVj
 xelAMsUsYFdnIrecMQgxqFqY2peEpljZftVFFdIgQ8U+Z1zsR8ZUmqv7ztactvjAgYORk37bXkw
 /hwljVPs9HbszPWDkFqBQNsWwrCH0GZD3F2E/Y0JJAqqFLImrk7QSuRCK/lMIrT2r2ZGC8OLFGo
 6MkxK3zKqT3WuIUOSKuNX5o6ApEZc/+p+RxuLUqKURxr91UQxy4woCE5Fq19pIFzRAwY6o0FbwE
 ubN039Dp9dXLEh/tRVr8z7l7JK0d9C5EHw8XCYlNVeerfNH//zwIEb2f8ZsFVps8HHsQKc011hS
 hahnFHnnRqmSoEbwkQBaye4dgL8G3q5t5TsrHwtbdZVVseGvUmW8vwM6pnX1xhCM+5JSTPWRZoI
 A+vI01uuyLhM+W+OSRdBJ+bWcz+SRzxS4S/bWZGNM9iw78lfz+AQ91RyP+LXzf49VWAUHSmvOM7
 N4n6/z8lUVxQRyqcba0sllQwzlt3mrGhVDpJYnmJrGpCLdHZO+mu+bKzQ9Pvzla6Uk1/5uVXphD
 qMtkbIHnG+6r2CQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Commit 84eaf4359c36 ("net: ethtool: add get_rx_ring_count callback to
optimize RX ring queries") added specific support for GRXRINGS callback,
simplifying .get_rxnfc.

Remove the handling of GRXRINGS in .get_rxnfc() by moving it to the new
.get_rx_ring_count() for the mvpp2 driver.

This simplifies the RX ring count retrieval and aligns mvpp2 with the new
ethtool API for querying RX ring parameters, while keeping the other
rxnfc handlers (GRXCLSRLCNT, GRXCLSRULE, GRXCLSRLALL) intact.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index ab0c99aa9f9a..33426fded919 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -5580,6 +5580,13 @@ static int mvpp2_ethtool_set_link_ksettings(struct net_device *dev,
 	return phylink_ethtool_ksettings_set(port->phylink, cmd);
 }
 
+static u32 mvpp2_ethtool_get_rx_ring_count(struct net_device *dev)
+{
+	struct mvpp2_port *port = netdev_priv(dev);
+
+	return port->nrxqs;
+}
+
 static int mvpp2_ethtool_get_rxnfc(struct net_device *dev,
 				   struct ethtool_rxnfc *info, u32 *rules)
 {
@@ -5590,9 +5597,6 @@ static int mvpp2_ethtool_get_rxnfc(struct net_device *dev,
 		return -EOPNOTSUPP;
 
 	switch (info->cmd) {
-	case ETHTOOL_GRXRINGS:
-		info->data = port->nrxqs;
-		break;
 	case ETHTOOL_GRXCLSRLCNT:
 		info->rule_cnt = port->n_rfs_rules;
 		break;
@@ -5827,6 +5831,7 @@ static const struct ethtool_ops mvpp2_eth_tool_ops = {
 	.set_pauseparam		= mvpp2_ethtool_set_pause_param,
 	.get_link_ksettings	= mvpp2_ethtool_get_link_ksettings,
 	.set_link_ksettings	= mvpp2_ethtool_set_link_ksettings,
+	.get_rx_ring_count	= mvpp2_ethtool_get_rx_ring_count,
 	.get_rxnfc		= mvpp2_ethtool_get_rxnfc,
 	.set_rxnfc		= mvpp2_ethtool_set_rxnfc,
 	.get_rxfh_indir_size	= mvpp2_ethtool_get_rxfh_indir_size,

-- 
2.47.3



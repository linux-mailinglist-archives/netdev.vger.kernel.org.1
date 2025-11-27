Return-Path: <netdev+bounces-242223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AA6C8DBE9
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 11:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7125434D11F
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 10:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3CF32AABE;
	Thu, 27 Nov 2025 10:26:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6990A329C7D
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 10:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764239190; cv=none; b=msCS8RphXqCNDzWPUaK7u0ATv5dp/N0oy/p65OZCxLV0eF0dD8HUWzsmH4Sfvgm09bSvTBi/WS1fvAcJMAM1A6rAPrsLlx0hojUVfF9+E68UfEF4ZRKhx3zPunI5xDOglF8Z9sRJBhbFPxV6RLLfZmCfeCrhEgZKO5ifs5FDybk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764239190; c=relaxed/simple;
	bh=ziNL3DpT6zcExHomPTJGBy+OfpgV1BW/TZRu2R/8p5c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SiiKjiXgUDaR+Xte46tBK4VyNBUybZlN+ieU6Y+ke7zncGowIyNtfxjElMzLN3zNBeR2GK6xFYGnuFfdXWidXV2g54WUiXiA42QuB7MEyyyxnXWsWubs8gxSpKC/J+PXNtYl/L89VXuzVnlHphGaUnibcgyrbV2Tkp0WsnbgXKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-3ec96ee3dabso523170fac.1
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 02:26:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764239188; x=1764843988;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jWAO97VRo8cNUjO9IOcf6f4bfb1chKcXNwtoNjNLSMk=;
        b=I0xf4W07vWMb1VDCu36zeOljkpZtjZgf/WXZ7orbCeY85CjpQmssCkVGRyOFFSSxQX
         AtDRP7+AiNCJv1Rc0QTqe/q48rpWdUBdFpvmnI2HSHbis1Q4l/hhACRy7TUUd6DizINy
         +7by9Z50mw0KPKtsaRNPvxoMX6lZ98evxvP3pPtlTZDW25VKVQgN7IM70RuMMwM9064N
         ieiFMr+wzdB5KP28sMBWiyqUKOa+SOsYusrMwc7ietPOcGWI9DKmjXEgLWUAZs/vQYF+
         vaO4FiGhoenAv9vfVnu84fRt4pHAlG484bZN7Liaxl3Qb8z/Jm4sZDs+7W2HLEEqzKyU
         Bk4Q==
X-Gm-Message-State: AOJu0YyzC2PLCVx56WG3azD+5GBXDQiTGcfh2h8QW/Ct0XX09LD4ZtwN
	+ky1I4m8o8Gw9deNMMFyPUY3zCX1XMf41TmyBosOKu0MMWtJ+++G3Pyc
X-Gm-Gg: ASbGncupr4BT6pFujEzuCVwNvIlNOGRSLwG0S+31IrQk2d5NR0HfaFKh+LPhIfuTA74
	eZ4QgnR7qiqKhfqE6a55vs1fzg3FGYt0BTHA7S7CT+lL+XenZsQtn3URMvMOzLdaKBDF+5qxsfl
	PyRMCrTx+edTWXFxbdArslYboaCgAiyKeBRiN7a/STb2t3q3QteNag8sVt07u9mKODyuOSsCvRk
	jY1Lww2J7jlabAt3mphOiaK8CuzT5KnZOS32WlRRz5TES4rZlMj2vGfOQWUJt6s8Fmjq1dETBJK
	+cAkm5pCtVJ8wvgo/rAOKU6NwEhKEmWQhxf2mcf2caYpGngvWugt/HBZDkizD0Vb/KqLT8frylL
	5ZqJpYwOLyzqeXySD8F+tweBqMU0cDIMATwtaaelTH/zr4jSMQXfsFAB9F9RMDgyqhRDb1zj2Ug
	PkU51RFBYWdylpGg==
X-Google-Smtp-Source: AGHT+IGxuGyO91FrGudoUvYvFx456+UgM33RNUXQFUYcpLY9SXnQtd96IWIYUEs7Z2xeCO4iU5vnXA==
X-Received: by 2002:a05:6870:a924:b0:3e9:1643:5977 with SMTP id 586e51a60fabf-3ecbe30b91emr9355059fac.18.1764239188427;
        Thu, 27 Nov 2025 02:26:28 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:46::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3f0dcfdbbdbsm355585fac.10.2025.11.27.02.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 02:26:27 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 27 Nov 2025 02:17:15 -0800
Subject: [PATCH net-next 1/2] net: bnxt: extract GRXRINGS from .get_rxnfc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251127-grxrings_broadcom-v1-1-b0b182864950@debian.org>
References: <20251127-grxrings_broadcom-v1-0-b0b182864950@debian.org>
In-Reply-To: <20251127-grxrings_broadcom-v1-0-b0b182864950@debian.org>
To: Michael Chan <michael.chan@broadcom.com>, 
 Pavan Chebbi <pavan.chebbi@broadcom.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Doug Berger <opendmb@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1910; i=leitao@debian.org;
 h=from:subject:message-id; bh=ziNL3DpT6zcExHomPTJGBy+OfpgV1BW/TZRu2R/8p5c=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpKCdR7zcv+3BUX4CNj4xyHHvLVq9+aAtxMbNwe
 Arr/7+fYuaJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaSgnUQAKCRA1o5Of/Hh3
 bW5YEACks84xKW/jSbZGCrgeHfCMgkF/VKQKULsxuslNBOblRXiqj+wAnCqQV69x9KE+IJgXS7S
 ihXpjphBci7K6yl8BumxF2vcUDq5uRxb1GB21Yk3gnXUveTUv+bgRc2QzZrGReYI7pb0i4r8VUa
 zZt04O52SiY8ZpGWwG1ZPTfL8To3WKzqnYx/Ci44RVkQ8u4UH7WhpFpDorAMWhFTuUXr/lnZmf2
 IhaZ5olFXQElKm9pHBeUYZsM8KEuvERajQ4KyLbwrrRzOIMHXCzB/W/2B++xnJTu6mP/Zjh7Pnp
 s/CuS1X0z7Ca68IN7tWdsdrID3GXfMzOGomAWVpg/1YMhg1vG/yCV8Mw8VJ9N9Wqjm3EiRNIhW4
 GnnPDWNtSfTQfQXMASTfc6D0jBl9KfOnHMBPIjHG6OQIoQe2RUyW9KfwGqeikkMX4XtLa6emGJw
 ps9C3ewPznmTj3zYkgoiq/4KmiKlBjUVWzzsbUH3dS022vJXHw3WMNXn7i+nWbakUPOXJE9SB5f
 f6tzw0XdLsWnfKGBIUiE/8uuSAoFX9u3g8wpWscN/IKVWGp/tr2YGFEv7CeOAy60Ll16Y3dz3ty
 nPGMzw0M3+agmbA/hFx1NTvWEvReQR2Jj9VzMSUea0Oqvjx540qEAFbuwcF7+4MF2L/zcfgauHW
 b495sybAhtpZizQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Commit 84eaf4359c36 ("net: ethtool: add get_rx_ring_count callback to
optimize RX ring queries") added specific support for GRXRINGS callback,
simplifying .get_rxnfc.

Remove the handling of GRXRINGS in .get_rxnfc() by moving it to the new
.get_rx_ring_count().

This simplifies the RX ring count retrieval and aligns bnxt with the new
ethtool API for querying RX ring parameters.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 41686a6f84b5..71f105eae310 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -1764,6 +1764,13 @@ static int bnxt_set_rxfh_fields(struct net_device *dev,
 	return rc;
 }
 
+static u32 bnxt_get_rx_ring_count(struct net_device *dev)
+{
+	struct bnxt *bp = netdev_priv(dev);
+
+	return bp->rx_nr_rings;
+}
+
 static int bnxt_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
 			  u32 *rule_locs)
 {
@@ -1771,10 +1778,6 @@ static int bnxt_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
 	int rc = 0;
 
 	switch (cmd->cmd) {
-	case ETHTOOL_GRXRINGS:
-		cmd->data = bp->rx_nr_rings;
-		break;
-
 	case ETHTOOL_GRXCLSRLCNT:
 		cmd->rule_cnt = bp->ntp_fltr_count;
 		cmd->data = bp->max_fltr | RX_CLS_LOC_SPECIAL;
@@ -5605,6 +5608,7 @@ const struct ethtool_ops bnxt_ethtool_ops = {
 	.set_channels		= bnxt_set_channels,
 	.get_rxnfc		= bnxt_get_rxnfc,
 	.set_rxnfc		= bnxt_set_rxnfc,
+	.get_rx_ring_count	= bnxt_get_rx_ring_count,
 	.get_rxfh_indir_size    = bnxt_get_rxfh_indir_size,
 	.get_rxfh_key_size      = bnxt_get_rxfh_key_size,
 	.get_rxfh               = bnxt_get_rxfh,

-- 
2.47.3



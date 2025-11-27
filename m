Return-Path: <netdev+bounces-242224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 825C6C8DBEF
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 11:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AE40134F73D
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 10:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F4232B98E;
	Thu, 27 Nov 2025 10:26:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E04632AAAE
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 10:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764239192; cv=none; b=LA0qrJiwLvyMGtEfwppjQvn1igvM+20Yi2AAYtLrLL8OLiORDQbl7R82KhJ5hR6HNrcJxAQS9Ph+zkwf1kgm6UUU4Td9/CIMufysRlwMGOvnfTBdGkvZMm/zUZMn6VrrL0gIxJ1zwUW36Joo26HiIf8t7JgKt1Zjau6L6C3N9a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764239192; c=relaxed/simple;
	bh=VCp7Y+Tood+qYY9gKVPbLuTiQtOR8gQ16oIE6JhuthQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W1QsQpn7rrORVrSH/r2xavqKvgE3o07bSzPr1tMA8MpDTk/eHS+FXXoS44Lyk5KM6C3A/vegCEpUlLmxhOu0rUKKb+GvIr7G2yXYHJ1cf6CveVV/8TkwCIx4wpU0DCw44ajyOrNswBw89xAbRDKfPxfi2xVKYWRrDhydybJmoTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-3d70c5bb455so215829fac.1
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 02:26:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764239189; x=1764843989;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A1AKmuP1PpwnfsktfsfygiNqAcVa5BhdNFVANeglQeI=;
        b=Q07t2/sxMJlSxSWP56U5G/mXuyVRyZ0XVYyW6HGUZbRnd7akllzld35dMA5IOXzXTT
         mVRMoRbyXOmKXwwLjg+Bu+aCwJ4B5Se4MoIi5FyflDROi+j++bKLGjzOTTdd6QGleZOT
         TmZFG4S17XiG60ApBY60+Tv1nY5n3D9JpEf+QpfQhdQnMxBag9x6T9/LrsbaNGkza6rp
         IoS1EveWhL68HJ4xp2tgqL4FLhiFzk9Dg65ek2s+mgj8NrMo2mGiaokwXb7+oMaSy1lQ
         hr8T4iETd6p2uKHUmM+R2NMhxSE6DJfSlG8bs3Xv9Y2weuOOnROFczXUt3hFQ9q8RiJ/
         teCQ==
X-Gm-Message-State: AOJu0YxN44S47UYK55d7VBkR6rls0iNrrpplB5PziCTH7LDsORgaAWsx
	lI4lHj8cyUO8+NT2EuRQtkCBK7fK9aDdrf3tWyKn+nzCdDUR/oq/JPnB
X-Gm-Gg: ASbGncsuUtIOKOpqz3dng+9sqy2nLA0FDC+Vqu/zgh9LbPSpPQBi4/fn2JHG759sYUI
	UDRfJRbW6hswNLFwPDUgBZxQen7w/cp+51R0gqv74W/QykDFQRGralKpXKuYSfvtM4PSWeF71UX
	s7sZ9jVDDMm1VHOsZ79g7QKMHDJnJ/VxvcRpPxa8BHBfXIDRvTDe3t7tfAgRaw4DTDXogEqir4/
	ltFemNAcTVrgDjnHrNyvWnm/XIa5Ls/9CmMZJKiF4uVwmltGlPLPABZmWR3HwPwZ9wzu9ZnbJSL
	SYZHxWPKZc8UmtzjsFS7/n0kndtM/KdgqhBs+RLFmNXqfqKk17M3xBrcOwoaphDvbD9+96/oNf4
	JXlrD1ZLgvyqVx84FS7wqdhl0Y5XsCdyvmRwmr+z8Y5pnseCSRVsCtwirJkP/mA7huZ8nXfpyZL
	0hb5OfAoaOypE8Mg==
X-Google-Smtp-Source: AGHT+IFc6lzuGdsJj0w9mKHy2vMevso+PQqCJqGAgOyqYEVarWmRO1Pt/Um0y5D+b3CPZa+Tf5FJ/w==
X-Received: by 2002:a05:6870:a193:b0:3e8:8dcb:cdbd with SMTP id 586e51a60fabf-3ecbe58b0ffmr10660650fac.43.1764239189634;
        Thu, 27 Nov 2025 02:26:29 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:5e::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3f0dd02a927sm354511fac.19.2025.11.27.02.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 02:26:29 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 27 Nov 2025 02:17:16 -0800
Subject: [PATCH net-next 2/2] net: bcmgenet: extract GRXRINGS from
 .get_rxnfc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251127-grxrings_broadcom-v1-2-b0b182864950@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1950; i=leitao@debian.org;
 h=from:subject:message-id; bh=VCp7Y+Tood+qYY9gKVPbLuTiQtOR8gQ16oIE6JhuthQ=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpKCdRPki6apUWu987FqBbqmLIB9pnz9Jx7FNbs
 FhZkWNanvmJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaSgnUQAKCRA1o5Of/Hh3
 bac1D/9/I4MOfUcDCCxydGc8qZb5rPXKk6C7BPmIyEvM9/3uuFwlu/PmXltMUmQSv+YqeyZyaNQ
 7NYDfTlh1E4mPpH93RUOoyk7RBfFLmchb/0Krq5qS0KRZF2B1L7IVzNxLY57GKdn/pUrERScx+e
 p1uDi1MAdxMcdrBGrfscp5rtWfbqJseVee9QohNGEQSeAxNtS0bGrcaHhA7jUeTEpIkVGPolI2z
 2MNB9xflCEOHzzWjfWK3nkZNx2hm6dlWv4y/twhQNNa1qIII8k8yowdwcmGlW+lmKBIsGgPed2H
 NZruEuGCyPuumC+p1SGF+E+vDJ2XGih41SZU3KWese6Jiu1/UgNThZtRctMpgVt7Pdsoc1Otobn
 giOoU+THBlmV8jk6JW6kPBVFZkGaEqbHsNHgzmOiYghnBGknOOgv+WfrZiqjr9IrZng2h7++UwN
 aNJaL0kbtEm5ndyZie6lxLHIvGgTwOALChtIMQ2J3XjKNuYI3CM4MyQ1WCoFu/SoO+ITiL1auaY
 Yv6Ogwrj7ZHeWah626xbqucA+qRVJp0wOa9yJwfKe0hV+eXNmGjImNmBNHM5aEOLBKA+xSyOCLJ
 dOX1QvHaZ6EVsGcWezM8CHTdXdCKn37Us+N/Noh2cOvaXOCJV8WO9GH2bK7wK9xS2LAn+uweRpc
 1ahHPZBakgscwhA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Commit 84eaf4359c36 ("net: ethtool: add get_rx_ring_count callback to
optimize RX ring queries") added specific support for GRXRINGS callback,
simplifying .get_rxnfc.

Remove the handling of GRXRINGS in .get_rxnfc() by moving it to the new
.get_rx_ring_count().

This simplifies the RX ring count retrieval and aligns bcmgenet with the
new ethtool API for querying RX ring parameters.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index d99ef92feb82..05512aa10c20 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -1640,6 +1640,13 @@ static int bcmgenet_get_num_flows(struct bcmgenet_priv *priv)
 	return res;
 }
 
+static u32 bcmgenet_get_rx_ring_count(struct net_device *dev)
+{
+	struct bcmgenet_priv *priv = netdev_priv(dev);
+
+	return priv->hw_params->rx_queues ?: 1;
+}
+
 static int bcmgenet_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
 			      u32 *rule_locs)
 {
@@ -1649,9 +1656,6 @@ static int bcmgenet_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
 	int i = 0;
 
 	switch (cmd->cmd) {
-	case ETHTOOL_GRXRINGS:
-		cmd->data = priv->hw_params->rx_queues ?: 1;
-		break;
 	case ETHTOOL_GRXCLSRLCNT:
 		cmd->rule_cnt = bcmgenet_get_num_flows(priv);
 		cmd->data = MAX_NUM_OF_FS_RULES | RX_CLS_LOC_SPECIAL;
@@ -1700,6 +1704,7 @@ static const struct ethtool_ops bcmgenet_ethtool_ops = {
 	.get_ts_info		= ethtool_op_get_ts_info,
 	.get_rxnfc		= bcmgenet_get_rxnfc,
 	.set_rxnfc		= bcmgenet_set_rxnfc,
+	.get_rx_ring_count	= bcmgenet_get_rx_ring_count,
 	.get_pauseparam		= bcmgenet_get_pauseparam,
 	.set_pauseparam		= bcmgenet_set_pauseparam,
 };

-- 
2.47.3



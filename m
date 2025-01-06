Return-Path: <netdev+bounces-155533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF05A02E5C
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 17:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78941188686C
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 16:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C871DED63;
	Mon,  6 Jan 2025 16:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXPr8Img"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5623B1DED57
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 16:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736182469; cv=none; b=HKbjmPM6oc918wYUTAmRPcBVn+9gGdImNcPLT3weOb7lIpAJzZnZ8v1m7lPJFHIb/G/OcQYq214YMRZPUI14wO6UguHVaBI/Zd6Wx9r/44SWKItb5S4FZA0ib214NUr9Izn5noaiC3If7qImQU4CcKETAJKuXPp+pMpBc9T6n/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736182469; c=relaxed/simple;
	bh=wiPFkU4WHOJT8dnrd9mkOu84E46PCoMN6rf9qjFkJ10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sJa9kSjGjoz1FQQB5zx+lYFir6aI0mzxAWkGAI016lgwlWKNatSlY8BgKlvwkI93t9D1dZ4s2wrQFA6UGirD3PvZ6BpDMvfGoHxLGWpX223AMBIFa5meVylkB093Ao5MYx05wPT/9n2Semai9S6NFP/p1L+i79ksO0V2h/L/dp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fXPr8Img; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93840C4CED6;
	Mon,  6 Jan 2025 16:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736182468;
	bh=wiPFkU4WHOJT8dnrd9mkOu84E46PCoMN6rf9qjFkJ10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fXPr8Img/QfcnHQbn0B9sAFU5KZNMfGyzOWQQ99Upeg9oLLHDesq4glDfmfSNlfmi
	 pFAE/g1f2xbRNGxht0rbHiEWACTE5MldoAUVsRi/g8FTtE5CPycwITc+G6fuo1k1P+
	 j0SLRBilXZe0EtMwfK7K6/5bMzAyMW8CAuKdAIYWJMXOe4B6K2sorBSTgzA26cNq4L
	 YohJktmDtCNLQ1Yj6XD8nqAkqiaIy4fQIP77pkOEQbPe0o3N23VoC/o1c/XHsRmUDk
	 wMNy+OD/0eA5xhoRCTgdAlBdISSZboL1Bd3XgiNY24pTCYb9XPRoxZerV9ucXiIjgA
	 +AXgpyQ4Ky2mA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	Jakub Kicinski <kuba@kernel.org>,
	nbd@nbd.name,
	sean.wang@mediatek.com,
	lorenzo@kernel.org,
	Mark-MC.Lee@mediatek.com
Subject: [PATCH net 5/8] MAINTAINERS: remove Mark Lee from MediaTek Ethernet
Date: Mon,  6 Jan 2025 08:54:01 -0800
Message-ID: <20250106165404.1832481-6-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106165404.1832481-1-kuba@kernel.org>
References: <20250106165404.1832481-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mailing lists have seen no email from Mark Lee in the last 4 years.

gitdm missingmaints says:

Subsystem MEDIATEK ETHERNET DRIVER
  Changes 103 / 400 (25%)
  Last activity: 2024-12-19
  Felix Fietkau <nbd@nbd.name>:
    Author 88806efc034a 2024-10-17 00:00:00 44
    Tags 88806efc034a 2024-10-17 00:00:00 51
  Sean Wang <sean.wang@mediatek.com>:
    Tags a5d75538295b 2020-04-07 00:00:00 1
  Mark Lee <Mark-MC.Lee@mediatek.com>:
  Lorenzo Bianconi <lorenzo@kernel.org>:
    Author 0c7469ee718e 2024-12-19 00:00:00 123
    Tags 0c7469ee718e 2024-12-19 00:00:00 139
  Top reviewers:
    [32]: horms@kernel.org
    [15]: leonro@nvidia.com
    [9]: andrew@lunn.ch
  INACTIVE MAINTAINER Mark Lee <Mark-MC.Lee@mediatek.com>

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: nbd@nbd.name
CC: sean.wang@mediatek.com
CC: lorenzo@kernel.org
CC: Mark-MC.Lee@mediatek.com
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 613f15747b6b..97e3939f800b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14573,7 +14573,6 @@ F:	drivers/dma/mediatek/
 MEDIATEK ETHERNET DRIVER
 M:	Felix Fietkau <nbd@nbd.name>
 M:	Sean Wang <sean.wang@mediatek.com>
-M:	Mark Lee <Mark-MC.Lee@mediatek.com>
 M:	Lorenzo Bianconi <lorenzo@kernel.org>
 L:	netdev@vger.kernel.org
 S:	Maintained
-- 
2.47.1



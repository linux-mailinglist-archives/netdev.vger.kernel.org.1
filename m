Return-Path: <netdev+bounces-106770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 944EB91794E
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 09:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F5771F2423D
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 07:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE653158210;
	Wed, 26 Jun 2024 07:01:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F69C1474CF
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 07:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719385319; cv=none; b=Z3tU0pvQj0uH0jlkVpIZ+EiZel2lZZEd7k/GKVyBQAyCc0iO+bhVHmVLZFvFo0VzcExCLkwb/UU7W3WOZ2M5axsMsR9MOWCiQK9XsJbymkrqOQpLdHxinAytZEap7J0P6AmJ80BkZ25XGcbzltrSA98mP6JhJvEKthVtU++O1VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719385319; c=relaxed/simple;
	bh=PIm68SNaeiGNrSumTkicE7cUXi5HkDF/nLGq+taI3nI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NTkYhP+DG3BX5afN3ZTOYjf2G1aXCWOSLU1LuTf5XkGRoDDNJDjrUcFKdhTcgZckkhmHz2L2jY6nF+6Gr8twmQyPOqMnaec4tVM+WX/lZjuLHeiqHtTceWR0ROBsqlPQ4CRL5F8E6/ZcdSM83AoSZFwxfQpxzntSWC3Jhm74+RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-424f2b7385bso458285e9.3
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 00:01:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719385316; x=1719990116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gOhUsvgsAX/B6UUgnLvZPaOmeZjPmrAP4TJS01whG0c=;
        b=tGLsgldWgKxvF8iz4C7PiKDlivBEyOg1TFKUxzImoFDWLjRMTH0u08NJBgqoK2Jv/7
         ss2M9o2ob16FyO2gM+GBISth6bjNnP4pJ0X1+MCSy23S5C5EPIvPrAugfcO4hCwI3jOv
         bLHZRSLYBBostQdUWOPxPpsP88O7Vu0280McwXl/DDbnErw634GiBty7gGltFJ/NcA+Q
         6YxukySz4T4Xi7B0fvGiDV9Kx3Ni2v3BqIxwCC+w1O2LWvH4cJDDpKfTXy6W/HUxvzX4
         ppWMCLI11jTA9r1BgvGqEtjYsQ/BfLvYI7UvD6RLwU2Oy9NyKpxxU3sUN9n5OVIPpaum
         Jbpg==
X-Gm-Message-State: AOJu0Yw/J44FvKfJO+Voc++ZRn6wne4HYkGYUUq7mtt0km7B+jhSP5dX
	xiBI1j4DRxvdSY6Ew50THuYQ4c55zlT2jqPj7kDegClmI7zNqeMjzzWtjw==
X-Google-Smtp-Source: AGHT+IFG2FKrtXO8Pr90yH4CHz9Z4B93JzpB7oeKfT7qmF4QT1sEx59eB5Md/WDUSqLkCIh5O8P2PA==
X-Received: by 2002:a5d:680f:0:b0:366:efc4:d424 with SMTP id ffacd0b85a97d-366efc4d8f4mr4871934f8f.4.1719385315731;
        Wed, 26 Jun 2024 00:01:55 -0700 (PDT)
Received: from vastdata-ubuntu2.vastdata.com (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366388c4282sm14905219f8f.31.2024.06.26.00.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 00:01:55 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Subject: [PATCH net-next v2] Revert "net: micro-optimize skb_datagram_iter"
Date: Wed, 26 Jun 2024 10:01:53 +0300
Message-ID: <20240626070153.759257-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 934c29999b57b835d65442da6f741d5e27f3b584.
This triggered a usercopy BUG() in systems with HIGHMEM, reported
by the test robot in:
 https://lore.kernel.org/oe-lkp/202406161539.b5ff7b20-oliver.sang@intel.com

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
Changes from v1:
- added target tree

 net/core/datagram.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/datagram.c b/net/core/datagram.c
index 95f242591fd2..e614cfd8e14a 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -417,14 +417,14 @@ static int __skb_datagram_iter(const struct sk_buff *skb, int offset,
 		end = start + skb_frag_size(frag);
 		if ((copy = end - offset) > 0) {
 			struct page *page = skb_frag_page(frag);
-			u8 *vaddr = kmap_local_page(page);
+			u8 *vaddr = kmap(page);
 
 			if (copy > len)
 				copy = len;
 			n = INDIRECT_CALL_1(cb, simple_copy_to_iter,
 					vaddr + skb_frag_off(frag) + offset - start,
 					copy, data, to);
-			kunmap_local(vaddr);
+			kunmap(page);
 			offset += n;
 			if (n != copy)
 				goto short_copy;
-- 
2.43.0



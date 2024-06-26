Return-Path: <netdev+bounces-106769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0E991794C
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 09:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBB521C227DE
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 07:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B63115885E;
	Wed, 26 Jun 2024 07:00:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EACA31
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 07:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719385245; cv=none; b=hFYMg++X277K6UUOcZs9LKY9XIbzHEngHPQdAcLeTOSbmTrACM+pnCryNcTlCdFiN+gZ/HiLpPAtfZuXsqAbeuES/mhyjPtYHr31bGhfKVK0yENMN3tBHaTrPMuB2T0ruW4QCGjLbmRpddiud2tnb6+jG0q/MC33r+GqkYcSupA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719385245; c=relaxed/simple;
	bh=4jCI1XAWVV5g/IyF/xJ9JdBM8duTxhA4eBl+ykHLqq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AadNFrN2aYwYDGBsicJGR1QUzFkRZgsKwFfsvIWjUH3pFs+rsbs+CyFobISlKcjx0Vev0JNzTOe4gsdzDd4hySXL2gBFwbX9jGc2J5B2W9uwZMHIsVwIFeA6WtRvRndSHOlf+RrPOp6wCNrBDnG7AIjZkrsDDEiPghyXBr6cA8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4247ae93738so8492115e9.2
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 00:00:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719385242; x=1719990042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hvxzwc0F0lP3YHoMsjdIJ3CYk0YAjGbyueK/28nhFxg=;
        b=DmN+tMap2fuA12H+xjrmGKNvOwCMfZQK5IGnKwLttQYIJOw1q2iMAQCObrDm5C+8Ap
         PZE/Uf7zKb1jTv6xajiLRooTTNwJLVA8aPLCP56vIiWpkkfQp2HHEVX+bgJYaXcG7UlT
         /jyMqrIOlX1P7lMWVGTdlnMUbg/5uh2bHGMHSH52aB9fMCavuWbmsMUkVhMyBDeu837B
         auNJxwGmeC/TYwecA/M3JC/2BOAjESddJg1coeb99iIny4GMFecLWcd8/bYy7jx58E3s
         5WpqWMfZZqs3atY4Tm7qh1RLdnPVFfYkW+M68Lw7P+D8Lun2AO0K9QjixQTu8iCOethk
         k0KQ==
X-Gm-Message-State: AOJu0YwyQ4JCfxbCFrLhAPf8EHSitpK1gnIttuh6Em75cDZl0DZhxBpp
	W1IgV4A7hDxjonL8bCJgxrThLrShKIP8NqqMjI4C9K/aivJR4+R0CrrmUg==
X-Google-Smtp-Source: AGHT+IGaGORJ0YRWo9TXzwpMeg9XDQpOJRqFZPKfQyKaJ28aKwy2fwVHMGWLGg48qoNvj08POWBCPw==
X-Received: by 2002:a05:600c:3c9d:b0:424:8b08:26aa with SMTP id 5b1f17b1804b1-42491783f09mr54421865e9.3.1719385241699;
        Wed, 26 Jun 2024 00:00:41 -0700 (PDT)
Received: from vastdata-ubuntu2.vastdata.com (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c823c28asm13728735e9.5.2024.06.26.00.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 00:00:40 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>,
	David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] Revert "net: micro-optimize skb_datagram_iter"
Date: Wed, 26 Jun 2024 10:00:37 +0300
Message-ID: <20240626070037.758538-2-sagi@grimberg.me>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240626070037.758538-1-sagi@grimberg.me>
References: <20240626070037.758538-1-sagi@grimberg.me>
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



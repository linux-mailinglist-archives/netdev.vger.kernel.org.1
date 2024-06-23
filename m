Return-Path: <netdev+bounces-105916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CCD9138F6
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 10:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB1931F219DC
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 08:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378BD5EE97;
	Sun, 23 Jun 2024 08:12:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13274CDEC
	for <netdev@vger.kernel.org>; Sun, 23 Jun 2024 08:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719130374; cv=none; b=CXTVT4JlfpOe7u9wSFbaMFPgcL3d2BHK5Zienb5OhcOGsXdVNfrDbrnpMh3bwQUkm01Gh0XTDvALUA1Q1aAC7hIfvV2VCOBkaXp8fxQWiId8yLJ/LsiNLT2FTAoFBccYK5MAVTLjPpaOWmmeWthP/laNRX3ZzU53CqTgxfRO8mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719130374; c=relaxed/simple;
	bh=SShJ3uH6p9oh3CuRy40Et0y7HlW3MUccUeFlQyGtuEY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yx6TYcFJG80+iv/EfHijh1igYKs0XXTcH70hRSHjBMJNb8vGHT007w2TWqznszY3L7AeQP9CxOtDooRVxemgPBDDnfJp7OCYfpy0F6CSbal+o5p2u6xc9wHNgFFlCSyTj9odV0yo08254dVCaYsz7pOpGydOEPFmtotnnwejzyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-366dcd38e6fso102323f8f.3
        for <netdev@vger.kernel.org>; Sun, 23 Jun 2024 01:12:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719130370; x=1719735170;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FgWuD8t0YOcGlihl0zTrgPTa3Z62Zpr6wwNpXTuCSaM=;
        b=hI7kSR3sy4sjnC04m6yo6zD3FqXkYPwDJEDROHOhS7s0YZ9NUg3IVHJJ/OXDNckKvm
         kiWYfcBN0TNbvONvE9EgnodoFbJqHmsFFs9xmkH3AWdCQKzYHIky4jqVEyTyAXEBR1Zs
         R/Tkfstz+nOKJQbJGUwOfqkw17+OIbIbIHWeyA5Wsct2sF57eFv0t7LwgyF5xee3absK
         HNncsQ0z+UyAACRp6hP7h1PIJKrPSaOkiTxQ1UDFduZWy0DBb6YSaz/N3kWNwXd8qYtc
         BGGrDGkLntdzusAxqhZwe5M8yxyQ5RVl/1Xjnvpa6rUYBn1AeXRtUij2+M7H8CN1MiVi
         nMfg==
X-Gm-Message-State: AOJu0YxJc75Zb5z60hz0U7RPsiFx9uH6loNcCDTlBLFlruysLHkJuR13
	2cbyjR+HonRlqWqI7fcUc0nptiLM0eUcWLg8DometA5V1MAHdSib4eFFeA==
X-Google-Smtp-Source: AGHT+IFO/tkzjbm359kC53j1ogt1SPWyWdlNsZbaeVdJjI5mCHK9TyE98KYCk5k3mHu144Bw6L3xFg==
X-Received: by 2002:a5d:6d09:0:b0:35f:2a75:91fd with SMTP id ffacd0b85a97d-366e2a6e0e0mr1775811f8f.6.1719130370109;
        Sun, 23 Jun 2024 01:12:50 -0700 (PDT)
Received: from vastdata-ubuntu2.vastdata.com (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a8c83e9sm6689672f8f.94.2024.06.23.01.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 01:12:49 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>,
	David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH v2] net: allow skb_datagram_iter to be called from any context
Date: Sun, 23 Jun 2024 11:12:48 +0300
Message-ID: <20240623081248.170613-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We only use the mapping in a single context, so kmap_local is sufficient
and cheaper. Make sure to use skb_frag_foreach_page as skb frags may
contain highmem compound pages and we need to map page by page.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
Changes from v2:
- Fix usercopy BUG() due to copy from highmem pages across page boundary
  by using skb_frag_foreach_page

 net/core/datagram.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/net/core/datagram.c b/net/core/datagram.c
index a8b625abe242..cb72923acc21 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -435,15 +435,22 @@ static int __skb_datagram_iter(const struct sk_buff *skb, int offset,
 
 		end = start + skb_frag_size(frag);
 		if ((copy = end - offset) > 0) {
-			struct page *page = skb_frag_page(frag);
-			u8 *vaddr = kmap(page);
+			u32 p_off, p_len, copied;
+			struct page *p;
+			u8 *vaddr;
 
 			if (copy > len)
 				copy = len;
-			n = INDIRECT_CALL_1(cb, simple_copy_to_iter,
-					vaddr + skb_frag_off(frag) + offset - start,
-					copy, data, to);
-			kunmap(page);
+
+			skb_frag_foreach_page(frag,
+					      skb_frag_off(frag) + offset - start,
+					      copy, p, p_off, p_len, copied) {
+				vaddr = kmap_local_page(p);
+				n = INDIRECT_CALL_1(cb, simple_copy_to_iter,
+					vaddr + p_off, p_len, data, to);
+				kunmap_local(vaddr);
+			}
+
 			offset += n;
 			if (n != copy)
 				goto short_copy;
-- 
2.43.0



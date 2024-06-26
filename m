Return-Path: <netdev+bounces-106823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4928B917D1B
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 12:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2BB81F23A1B
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 10:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9F616FF50;
	Wed, 26 Jun 2024 10:00:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B68122083
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 10:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719396015; cv=none; b=Az4DIfZ2JL3pwWWiQTYOaj8l71K0v3JAC4gs8P08bVUoJzpI+StA3EBAcGth46OW2I9WzdnJq8xtNVB1ygnTj0+abZmzyseaLvgQI9paRpZUFn6FS15wTsAfDMt0rmHvyIqwmA8I9klzVa0TIADnTHHneaAn9nSPdey7lPlJXjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719396015; c=relaxed/simple;
	bh=0ik3fK6vQqNigJm2TF0ejERVC2yyPM2Bj2VUT2oEmt0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rMIe1e9lzUtYI2gbQXyRT4gYi3PaLDFBGwsm7YmptkwkpMp2vGLELq9KZnZLBxaKJ5Eq0hXBn7XGMdn/vqKjL0pR7KooeUc9CDWDCIYTMQsP0PA3v12lVb8JYSiibw0Q90kjS/L8YcpGix8eXKBfAQpOo2mDBJcX6R+fGkJtfcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-424aa34bf44so1127545e9.3
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 03:00:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719396012; x=1720000812;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XR3p51O1WF/P4/fO/4hOinjEJ0TALtuI6ZWXV8vN4UA=;
        b=JLg6MFyOLgYa89EWmjL7AAR8wRBOACvmI9CeCZMgfU+zrMonVSIxz3QpMcjGFUsWE/
         CcMI2R3ZVVoa6WzadfL5EMh5Yo0rjNu+I+2rJOGanWRyCi0K37ySsGlmfAr67kj/N/XR
         yNyF+VTgRzkmLndp7QuD/UhDzW5SoFAS+ad7OqHW9XnAFfiFOpJedCos+Wim4L4+oUdy
         SsmL6JtIbV/wd/gxNIYQKJgcpMTJklSEvlH60/V1jcI+owUSJuCuqCCDd43KmrSDKmOE
         GQ3BP5lEjLk1t0NnwPUlobNtnZKYeVSsuE8bWZ5ZcKyr0RTK49MveBt4rS8JtjEA41Yl
         xC6Q==
X-Gm-Message-State: AOJu0YwKRb5RGUioHSN8iqDGn6ElDfffeVfme3/pckrHUvQYHu+MzN0n
	Lx/qilmi7k6b+aiIxUppN9RsH/R8vnc/WOhepUxycoXgxXpt29svSEnv6Q==
X-Google-Smtp-Source: AGHT+IHG1GKzaNz2NUW2zrnA2ipYoilsOa3+sm6M4EtOnoDHbJT2G/93/Su7aIAMmMKyUInfkmEFbg==
X-Received: by 2002:a05:600c:4aa9:b0:425:5ed5:b416 with SMTP id 5b1f17b1804b1-4255ed5b5edmr7377605e9.1.1719396011654;
        Wed, 26 Jun 2024 03:00:11 -0700 (PDT)
Received: from vastdata-ubuntu2.vastdata.com (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c8278305sm19284765e9.32.2024.06.26.03.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 03:00:11 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Subject: [PATCH net v4] net: allow skb_datagram_iter to be called from any context
Date: Wed, 26 Jun 2024 13:00:08 +0300
Message-ID: <20240626100008.831849-1-sagi@grimberg.me>
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

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202406161539.b5ff7b20-oliver.sang@intel.com
Fixes: 950fcaecd5cc ("datagram: consolidate datagram copy to iter helpers")
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
Changes from v3:
- Add a fixes tag

Changes from v2:
- added a target tree in subject prefix
- added reported credits and closes annotation

Changes from v1:
- Fix usercopy BUG() due to copy from highmem pages across page boundary
  by using skb_frag_foreach_page

 net/core/datagram.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/net/core/datagram.c b/net/core/datagram.c
index e614cfd8e14a..e9ba4c7b449d 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -416,15 +416,22 @@ static int __skb_datagram_iter(const struct sk_buff *skb, int offset,
 
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



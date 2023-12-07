Return-Path: <netdev+bounces-55090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C11809529
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 23:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B51BB281720
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 22:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8DA840F0;
	Thu,  7 Dec 2023 22:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HA9j3ubU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029D81703
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 14:16:34 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5d279bcce64so12450317b3.3
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 14:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701987392; x=1702592192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r+qZVzaX5tBSZZX0iWz8hVeDA5JvQVhn0aKr9kjWXCI=;
        b=HA9j3ubU/m3u+L+VTWRSXhrNwCtCGYo9ndEE+S4EukvNnnu7N6nRm+cJYWXYwic6Kk
         fwa/g1kfU/FyosjoPtu32ReCYeYFNHIVNRg1crjH/zYEfOS3dwu0PYe54UGU2k/YXIeg
         5kutXch/M5Gz6zjISeBWBkYt5mdQyeJsVAJGRucVYN0XcH34w8/RUtqY6Phe33G/T5MF
         VLBa2VrNIXhaLfy2oGBqrJz+P9Aktj9VdGCFrXol3F7a7O/sZu3JeoVYwwxpPbnIKnGb
         arhOkwbrZLxSa14LBVIIAL+o6Po+2QvaVCroz1h0fOJC5s8ilST6bi60VUN971yggOB4
         5rUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701987392; x=1702592192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r+qZVzaX5tBSZZX0iWz8hVeDA5JvQVhn0aKr9kjWXCI=;
        b=ubrUe5cVXKMM0P+xxJFIJ28LJN4YhVD01zhshYwdRtbo0F3F9cGafBo0f5x4DXUGCl
         C9GMYSOhlQnvXuZJOsP9Xpe1gahyXkDhCM/s5TzBZz8uCZbXNLbXV+HivLb1uHZb0cFX
         yFcoKQobUt5ZFtrOjquaK1iMEm7NoGjzA3YxMB43rRGqOYhXOrim5VCPhfc+v6BGnkcA
         I7eP7HrnPfXdjj6S9Sagq44zpefhmVm3ih2yWsxGptFPU51MaeJF7LGwIliZzRpvMhY5
         uUL6OZviEv+oTcmn2x3Ez74Xi0XjPGEJ1u/LAyFMeV9IHAbvb6TjT0kn6UdWT02ZcaOk
         NK7A==
X-Gm-Message-State: AOJu0Yz7xczpR/4XK/s5SBbCjtbT7rfjkGIzTxRFnpoXiD3GW7GMGmp8
	4eorpgr8a9egO21FyB/BC0D9KmDANvgchQ==
X-Google-Smtp-Source: AGHT+IGWqY89KjyKrjEXCOE+7Qbz+2k+/AS74Rwoqr3trFnzqB1AvBBpAm7+LNworLw+Pngo7YudYg==
X-Received: by 2002:a81:b185:0:b0:5d7:1941:2c3a with SMTP id p127-20020a81b185000000b005d719412c3amr3097228ywh.103.1701987392667;
        Thu, 07 Dec 2023 14:16:32 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:57df:3a91:11ad:dcd])
        by smtp.gmail.com with ESMTPSA id c2-20020a81df02000000b005ca99793930sm204109ywn.20.2023.12.07.14.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 14:16:32 -0800 (PST)
From: thinker.li@gmail.com
To: netdev@vger.kernel.org,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	edumazet@google.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>,
	syzbot+c15aa445274af8674f41@syzkaller.appspotmail.com
Subject: [PATCH net-next] net/ipv6: insert the fib6 gc_link of a fib6_info only if in fib6.
Date: Thu,  7 Dec 2023 14:16:27 -0800
Message-Id: <20231207221627.746324-1-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

Check f6i->fib6_node before inserting a f6i (fib6_info) to tb6_gc_hlist.

Previously, it checks only if f6i->fib6_table is not NULL, however it is
not enough. When a f6i is removed from a fib6_table, it's fib6_table is not
going to be reset. fib6_node is always reset when a f6i is removed from a
fib6_table and set when a f6i is added to a fib6_table. By checking
fib6_node, adding a f6i t0 tb6_gc_hlist only if f6i is in the table will be
enforced.

Fixes: 3dec89b14d37 ("net/ipv6: Remove expired routes with a separated list of routes.")
Reported-by: syzbot+c15aa445274af8674f41@syzkaller.appspotmail.com
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: dsahern@kernel.org
---
 include/net/ip6_fib.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/net/ip6_fib.h b/include/net/ip6_fib.h
index 95ed495c3a40..8477c9ff67ac 100644
--- a/include/net/ip6_fib.h
+++ b/include/net/ip6_fib.h
@@ -512,7 +512,10 @@ static inline void fib6_set_expires_locked(struct fib6_info *f6i,
 
 	tb6 = f6i->fib6_table;
 	f6i->expires = expires;
-	if (tb6 && !fib6_has_expires(f6i))
+	if (tb6 &&
+	    rcu_dereference_protected(f6i->fib6_node,
+				      lockdep_is_held(&tb6->tb6_lock)) &&
+	    !fib6_has_expires(f6i))
 		hlist_add_head(&f6i->gc_link, &tb6->tb6_gc_hlist);
 	f6i->fib6_flags |= RTF_EXPIRES;
 }
-- 
2.34.1



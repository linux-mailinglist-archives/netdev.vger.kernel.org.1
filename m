Return-Path: <netdev+bounces-33006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4801379C30B
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 04:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DA031C209EA
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 02:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3284B651;
	Tue, 12 Sep 2023 02:36:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A3617EC
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 02:36:01 +0000 (UTC)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CF21DC06
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 19:36:00 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c3bd829b86so12064045ad.0
        for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 19:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694486160; x=1695090960; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ToE9qlc0hrK/B2lzmWsSf3qcFDaXUdrfslkv/aToLkY=;
        b=MTndbKx7aFio6dUuBEtGhfOtVJCTZfAtobePmMd5HYCKsFrStw60y+3X49ZWw+wvxC
         3pQXQR9SlZuDEEASU22IgEII/HKd7nExd/39IXhPXfQY3N/bRVnD5h2yzpMW25yCtT3k
         6UIQSGaBCPhhWXIegVAQIKULPlJB97DFWnmgMD0AvaNGO3GuLjtyH37hI1TiZqRMbsPd
         aj3OdrKAKmGi1fGVcytOxbze5NHCVvkeccVLE8WtSK/ZjCmvAyNQepW9AGSYKTRjouAj
         Jy9Y/8EYbuSvXT7I0lwpY7HiVChFLgQuMfBc00HaFvzZGNR0NEqb8uoL5yTH5/dUANPV
         8dYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694486160; x=1695090960;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ToE9qlc0hrK/B2lzmWsSf3qcFDaXUdrfslkv/aToLkY=;
        b=JiDborfVZw8dl9hc1Q06AUW1H8Ao9k+j62EG7hQOKcviXyqSVIE219MhwkvTeuCEXX
         ksn1Px3pZWRa/2HvHYtn+0T5cZluqkH38HsH60zhp7eSj4qgW3fYuCa5I35esNINY5NV
         6EkcaXGIx0pGLomnjUEAJyWHdgKtcNIBvSrkg/vUAarRWAV1mEOJcJ1QPU/YWGbFTXwz
         +NbXLtI5raBzHQlFtfFCwPhBZox1wrXF1euLvDvrWDpf5LNNMV3VB4dEqRlO4/KN2ppr
         4xcC5Se8QlZOZjr6CtN8gvw4SJ5cZAo+v3rombxtiYXdrWDeGZtkwCaDQ42IZe9+99Ze
         Angg==
X-Gm-Message-State: AOJu0YzfBggZiItZIR783Pi1xJjMDoXqPfx8vqfzggGD91tt+09XWyZt
	eKGJk3FPuDD8B3XAP8Jujes=
X-Google-Smtp-Source: AGHT+IF0oh06pu5lH/V3ki0+rRjLoe/xTyTJPTUG9lfjMUR2ASwQbPRxbKaiUOenkCIbPsOyEBA45Q==
X-Received: by 2002:a17:902:ecc4:b0:1c0:d8e8:38cd with SMTP id a4-20020a170902ecc400b001c0d8e838cdmr11667037plh.9.1694486160147;
        Mon, 11 Sep 2023 19:36:00 -0700 (PDT)
Received: from westworld (209-147-138-147.nat.asu.edu. [209.147.138.147])
        by smtp.gmail.com with ESMTPSA id z4-20020a170902ee0400b001bf5e24b2a8sm7189421plb.174.2023.09.11.19.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 19:35:59 -0700 (PDT)
Date: Mon, 11 Sep 2023 19:35:57 -0700
From: Kyle Zeng <zengyhkyle@gmail.com>
To: pabeni@redhat.com, dsahern@kernel.org
Cc: vfedorenko@novek.ru, davem@davemloft.net, netdev@vger.kernel.org,
	ssuryaextr@gmail.com
Subject: [PATCH net] fix null-deref in ipv4_link_failure
Message-ID: <ZP/OjT62OGVxwa3t@westworld>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Currently, we assume the skb is associated with a device before calling
__ip_options_compile, which is not always the case if it is re-routed by
ipvs.
When skb->dev is NULL, dev_net(skb->dev) will become null-dereference.
This patch adds a check for the edge case and switch to use the net_device
from the rtable when skb->dev is NULL.

Fixes: ed0de45 ("ipv4: recompile ip options in ipv4_link_failure")
Suggested-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Kyle Zeng <zengyhkyle@gmail.com>
Cc: Stephen Suryaputra <ssuryaextr@gmail.com>
Cc: Vadim Fedorenko <vfedorenko@novek.ru>
---
 net/ipv4/route.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index d8c99bdc617..cba0d148c27 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1213,6 +1213,7 @@ EXPORT_INDIRECT_CALLABLE(ipv4_dst_check);
 
 static void ipv4_send_dest_unreach(struct sk_buff *skb)
 {
+	struct net_device *dev;
 	struct ip_options opt;
 	int res;
 
@@ -1230,7 +1231,8 @@ static void ipv4_send_dest_unreach(struct sk_buff *skb)
 		opt.optlen = ip_hdr(skb)->ihl * 4 - sizeof(struct iphdr);
 
 		rcu_read_lock();
-		res = __ip_options_compile(dev_net(skb->dev), &opt, skb, NULL);
+		dev = skb->dev ? skb->dev : skb_rtable(skb)->dst.dev;
+		res = __ip_options_compile(dev_net(dev), &opt, skb, NULL);
 		rcu_read_unlock();
 
 		if (res)
-- 
2.34.1



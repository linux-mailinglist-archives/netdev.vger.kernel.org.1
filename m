Return-Path: <netdev+bounces-43308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8600C7D2467
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 18:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7503BB20D9D
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 16:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B6910A2A;
	Sun, 22 Oct 2023 16:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3q+6Bn3"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B580810A23
	for <netdev@vger.kernel.org>; Sun, 22 Oct 2023 16:21:33 +0000 (UTC)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC51D73;
	Sun, 22 Oct 2023 09:21:31 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-7789a4c01ddso178163785a.1;
        Sun, 22 Oct 2023 09:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697991691; x=1698596491; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B42kI3To7XoU3GKwYbYl8vB8ggJa0kdJgAmvrJnzDMo=;
        b=O3q+6Bn3rOx07jtmBxKm/7MhBSDDyxqyc3t3vQcbwRkanpUGJhJDVoakYl9goRufJ+
         ItJaH5V/AtPrn5l+8rNoW4FlqIreK3i131ZjuWoMneFnhmIeaNBYxkfiWPF+SsIIG0aW
         TNZOLXtPnmkA+xslOJ8nBNOH45tlKqFvJZDGV4q2Ce8DavXWAE+95VeVI7nDxO1Ui59U
         rxV3oyVcZrjeXtxEik1XBf/CVAT5pGyyBo0umc+1hlbcnVYE+baUXBo3xY6FT4TTpyCn
         V7YcrMxZxwZWYHWafzpGNFjghUQ8TqIbvy79zwHnGouO4xIBkcpfdEa1H7sBKszCLXrA
         4Zow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697991691; x=1698596491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B42kI3To7XoU3GKwYbYl8vB8ggJa0kdJgAmvrJnzDMo=;
        b=e4BPgrkFVVsWsWhU2H4Pz+NTUSPXG5IpfSUfomXu34TgYDB9EEwNDBc+l6PYuZ+Aot
         bGEpa4G84MpWh1sxtOObwkhToTedK+jV6H4chj4PoIJ8WpaTsaNRJZUJqcMNgeqZhwj+
         NIdgdfWCYQwjzsMb0LA4riTUkoQyOYztClxN6Gw0S5jx0qgPnfACygjuClh4KRfY89Wk
         9a/qAd33r8/E51l5nm9RHLkIp/pNhogRC6UqW+Gu58sTThFbLDI2YdTKmNnqC/Zai60y
         On5qNaPdyqtOcEG4iat9OPRlZpAgSfvY0/LDGOCvMq9sZWuRxwiJ5ZDy9uFk98WxlJ/q
         QTzw==
X-Gm-Message-State: AOJu0YwR8Ecnf9407CnEG0Hoa1zq/xv9+QbdEv67QC6ffZeeaMeM3mN+
	XFRqRpTLABnew4MnkDS1ZG/uoOvYRtuGOK9B
X-Google-Smtp-Source: AGHT+IHmvRLBHeZI5aUo/C1NZtg677fSDmy3Nqw1az7AFAfhNxGiDeFVp9rm3helVhVt3ayDzdXrzA==
X-Received: by 2002:a05:620a:27d4:b0:777:ac06:ed91 with SMTP id i20-20020a05620a27d400b00777ac06ed91mr6766124qkp.23.1697991690683;
        Sun, 22 Oct 2023 09:21:30 -0700 (PDT)
Received: from localhost ([2601:8c:502:14f0:d6de:9959:3c29:509b])
        by smtp.gmail.com with ESMTPSA id x9-20020a05620a14a900b0076f1d8b1c2dsm2107244qkj.12.2023.10.22.09.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 09:21:30 -0700 (PDT)
Date: Sun, 22 Oct 2023 12:21:29 -0400
From: Oliver Crumrine <ozlinuxc@gmail.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: davem@davemloft.n
Subject: [PATCH net-next 15/17] Modify occurences of cork to make it a pointer
Message-ID: <e4dc390bf9089de925348d9ed81605956e65ad93.1697989543.git.ozlinuxc@gmail.com>
References: <cover.1697989543.git.ozlinuxc@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697989543.git.ozlinuxc@gmail.com>

Update an occurence of ockr to make it a pointer, just like all the
previous patches

Signed-off-by: Oliver Crumrine <ozlinuxc@gmail.com>
---
 net/ipv6/raw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index 42fcec3ecf5e..3ef5a75dcb79 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -520,8 +520,8 @@ static int rawv6_push_pending_frames(struct sock *sk, struct flowi6 *fl6,
 		goto out;
 
 	offset = rp->offset;
-	total_len = inet_sk(sk)->cork.base.length;
-	opt = inet6_sk(sk)->cork.opt;
+	total_len = inet_sk(sk)->cork->base.length;
+	opt = inet6_sk(sk)->cork->opt;
 	total_len -= opt ? opt->opt_flen : 0;
 
 	if (offset >= total_len - 1) {
-- 
2.42.0



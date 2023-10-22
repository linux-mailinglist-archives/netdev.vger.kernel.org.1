Return-Path: <netdev+bounces-43304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D67D7D2460
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 18:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6494B20CA3
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 16:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB5710A1B;
	Sun, 22 Oct 2023 16:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMRgLTgD"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA4E1858
	for <netdev@vger.kernel.org>; Sun, 22 Oct 2023 16:21:08 +0000 (UTC)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1E210F8;
	Sun, 22 Oct 2023 09:21:04 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-778a20df8c3so182632985a.3;
        Sun, 22 Oct 2023 09:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697991663; x=1698596463; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hgjSE66tE6JZzaSVNRveIcOcsT4Kj5DPZibrG3bgtDk=;
        b=fMRgLTgDCcKkgPYu+FQMBqi63sEtiqcCOwvRbdL9vkHSvPUtvGgIGomfeVtCCw1ASC
         A8ckRs8LaGbl1OGMGOaLn6HNipC9wwRaJp1kMDh5GwmKByOwZp0AlxB1QiKziEsljs9p
         VcVxtxZf6uukrJAaesAG2ZhuUsn1Y7AV6qOhIFz2jIFefqdiX1CecHCgmKr+ZTqWjOqa
         p64zge+W7VZfOGmykDh3XWh1HBzqkMvgCPuAyS2zxf3OUbUUOsN+DAWNKDVnMAN5uqIR
         YYVpqcwDh8C36f4tB1Y7YvUoyCM2ICUE7J3f0uTZJBZFZFl1Tu+dPv8apZKmKhCiaVGG
         8A0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697991663; x=1698596463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hgjSE66tE6JZzaSVNRveIcOcsT4Kj5DPZibrG3bgtDk=;
        b=LvBnUafB7QqTFlQC29P4X8v7phtRuDAmDCmIlUUKCW+0sCnhzlJVEgDcDb1+s1ZJCi
         D0mke+Itwao7sO0TDXnRfaBOYr5E0/1L83VFmZ6++NASVa4R/Fe/Stf/CNMaDAYiLS2D
         V0SiYTMPsRts6ut+u81c/9ZjXbT9KS7DacceUZRY2+3j5bNva4WeotE0+8XcA4uhkZXq
         fzk96rsn2iEakFJB5ia6rkiELEQdSIgH4zBeVC368JubsVRpwp2ZYMDqdMWEsOerc+4l
         Racwv00E8jEBE7/+uArXKE6r5mrkEQnox3CzAnCInhLntJ2Y/lB+02DJH97iGpOeQjxC
         MfEg==
X-Gm-Message-State: AOJu0YzdjJkrygQyn9RlG/vKFUIAKkGZ61w163b9xR9+JlFPQNilhw6m
	P2OA/kNE9IzGrYCoZ/qxqhoNu2yEZhBDh8U6
X-Google-Smtp-Source: AGHT+IF6sf0pgRs8aF7roOUY/S7wbWoMyZ/ISqtmhLlos7gvoDOZ83B942EJZE46bHs2QtNaevlPsA==
X-Received: by 2002:a05:620a:3710:b0:76e:f638:bcd9 with SMTP id de16-20020a05620a371000b0076ef638bcd9mr8966868qkb.38.1697991663249;
        Sun, 22 Oct 2023 09:21:03 -0700 (PDT)
Received: from localhost ([2601:8c:502:14f0:d6de:9959:3c29:509b])
        by smtp.gmail.com with ESMTPSA id e6-20020a05620a208600b007742218dc42sm2094338qka.119.2023.10.22.09.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 09:21:03 -0700 (PDT)
Date: Sun, 22 Oct 2023 12:21:02 -0400
From: Oliver Crumrine <ozlinuxc@gmail.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: davem@davemloft.n
Subject: [PATCH net-next 11/17] Update occurences of cork to pointer
Message-ID: <b9db0ba9fe244bd0574adba6764c647b08714724.1697989543.git.ozlinuxc@gmail.com>
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

Updates an occurence of cork to a pointer in accordance with the
previous patches in the set

Signed-off-by: Oliver Crumrine <ozlinuxc@gmail.com>
---
 net/ipv4/syncookies.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index dc478a0574cb..4354a4decb51 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -450,6 +450,6 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	 * Normal sockets get it right from inet_csk_route_child_sock()
 	 */
 	if (ret)
-		inet_sk(ret)->cork.fl.u.ip4 = fl4;
+		inet_sk(ret)->cork->fl.u.ip4 = fl4;
 out:	return ret;
 }
-- 
2.42.0



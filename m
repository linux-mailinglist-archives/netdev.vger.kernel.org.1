Return-Path: <netdev+bounces-43303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C26C27D245E
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 18:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62D49B20CA3
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 16:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC4310A17;
	Sun, 22 Oct 2023 16:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NB5qujsP"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E06810A09
	for <netdev@vger.kernel.org>; Sun, 22 Oct 2023 16:21:00 +0000 (UTC)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5FB197;
	Sun, 22 Oct 2023 09:20:55 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1dd71c0a41fso1937190fac.2;
        Sun, 22 Oct 2023 09:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697991654; x=1698596454; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q3eUP6wW7BMqU4z5aN2e2S0C74STyHyYsk0Wx3zx7Fc=;
        b=NB5qujsPEKObiA4r2K/tZFDisjEdeLRvf6pjMQ/G0U4HMlKkTJ4k2hieOvkJXQA739
         0958QWJhR973Ymopjl3t+ChwwU/3axT+/4/slAuzrunLu6HSmpvf8wy4/iJ147cubwIa
         F529COGDB+cR46cp/aMVvr1nzklJJg2kUxBLDR5oWwIC/gF5GCISbjvpMAAzP7+zeR/s
         jqMR2Zj2GuPP+60aRW28VQB/A6To34JmrQYO58A104KlF66Pf3me536lEt4cX4upZa7h
         mnHd5qZhiYK1oHCNnNAkxUjaqoGNdOJvsSmNkpMW/4xN003ANcVESuaJJC6L5RsTnxxf
         F8Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697991654; x=1698596454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q3eUP6wW7BMqU4z5aN2e2S0C74STyHyYsk0Wx3zx7Fc=;
        b=PIYT5ZjYbpSQBbp4T3KlMgIry/NEkp/yIrK4HSPLnTKTKzXH/cRgw/4YHe0k9QPbwb
         fgB7nwSNkPexkRa1gX5kxee7nLqTmGoMkSwGxx1Bzry4SM1kTjx7lYT8S0q9oX11IMP2
         8mkaXp+Ov7B55dK/irt5aAbRNzitpJf0fNOct5spDgQH9lkcnLZoIFYc6N6PT5rL89Ej
         lYSLkRG1xaz/Sv8HA+WCNUsBhi9aoJzKr9B8yDl1gPH5qIWnx/Lz9gGGly7SQ/tZzEU8
         EeOUByVMqKYAX45qOphLepanJ+6m5PaN7iGP1721nDSaDs36704/53yzVE2oHGzYPkF1
         szdw==
X-Gm-Message-State: AOJu0YzAePUf72aHh94uRhRLuEB8FiafzGjhDi7QyfRNiOsKdFajyZW9
	KVeAXy/pX9s5lInmm298ae/oL/6iVhZsynZg
X-Google-Smtp-Source: AGHT+IF38aO4Nu3Iu2slQgQaDix/Vly6XxDOl11vP8iWfTd5hB5+9Z+qcj+ZIez1sajBJzxw+uEZ/A==
X-Received: by 2002:a05:6870:57:b0:1e9:bb7b:6dd0 with SMTP id 23-20020a056870005700b001e9bb7b6dd0mr7603909oaz.55.1697991654564;
        Sun, 22 Oct 2023 09:20:54 -0700 (PDT)
Received: from localhost ([2601:8c:502:14f0:d6de:9959:3c29:509b])
        by smtp.gmail.com with ESMTPSA id h12-20020a05620a10ac00b00765ab6d3e81sm2108047qkk.122.2023.10.22.09.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 09:20:54 -0700 (PDT)
Date: Sun, 22 Oct 2023 12:20:53 -0400
From: Oliver Crumrine <ozlinuxc@gmail.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: davem@davemloft.n
Subject: [PATCH net-next 09/17] Change instances of cork to a pointer
Message-ID: <37fb362cff69dc98dcd1a8bcaab0560964120117.1697989543.git.ozlinuxc@gmail.com>
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

Make these usages of the cork a pointer in accordance with the previous
patches.

Signed-off-by: Oliver Crumrine <ozlinuxc@gmail.com>
---
 net/ipv4/inet_connection_sock.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 394a498c2823..99eb394ba0a3 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -830,7 +830,7 @@ struct dst_entry *inet_csk_route_child_sock(const struct sock *sk,
 	struct rtable *rt;
 
 	opt = rcu_dereference(ireq->ireq_opt);
-	fl4 = &newinet->cork.fl.u.ip4;
+	fl4 = &newinet->cork->fl.u.ip4;
 
 	flowi4_init_output(fl4, ireq->ir_iif, ireq->ir_mark,
 			   ip_sock_rt_tos(sk), ip_sock_rt_scope(sk),
@@ -1482,7 +1482,7 @@ struct dst_entry *inet_csk_update_pmtu(struct sock *sk, u32 mtu)
 	struct inet_sock *inet = inet_sk(sk);
 
 	if (!dst) {
-		dst = inet_csk_rebuild_route(sk, &inet->cork.fl);
+		dst = inet_csk_rebuild_route(sk, &inet->cork->fl);
 		if (!dst)
 			goto out;
 	}
@@ -1490,7 +1490,7 @@ struct dst_entry *inet_csk_update_pmtu(struct sock *sk, u32 mtu)
 
 	dst = __sk_dst_check(sk, 0);
 	if (!dst)
-		dst = inet_csk_rebuild_route(sk, &inet->cork.fl);
+		dst = inet_csk_rebuild_route(sk, &inet->cork->fl);
 out:
 	return dst;
 }
-- 
2.42.0



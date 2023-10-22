Return-Path: <netdev+bounces-43301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D387D245B
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 18:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5215A2814F3
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 16:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B533B10A09;
	Sun, 22 Oct 2023 16:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPNL8Wmd"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF48A1858
	for <netdev@vger.kernel.org>; Sun, 22 Oct 2023 16:20:48 +0000 (UTC)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D62CD52;
	Sun, 22 Oct 2023 09:20:45 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-777719639adso153413685a.3;
        Sun, 22 Oct 2023 09:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697991643; x=1698596443; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3w20SDE19R7M/DBYsehJexNI3rG7cUtG/NhFavJbLJk=;
        b=aPNL8Wmdv02ptk8uFNKKJwbRENvPKZkD40/cnEH5tGvRyaiLqFEchMzU+96w5QrYSO
         GQHhly9jbhNw0+V0XAEp9EQVmZMR6xDwTmDmQNkwPMgpwtSoboJTh7HzqAM6muGBBMPo
         OA8FP7gIsb/0kTkAWPojR3Oi+n8ChV42Q8nLyR77s0/DUCbA0+9iM8M+vElasDn+J9hT
         IyJAT9ugS9vyv3qIoLjLpjnD+oeqhfWtztSeBcn+t9FSOG99jBrRhyPhVcL2mI0+k2he
         LJUyRIb+kUcJtivDpq9dP0zM9l5qSIdONc0dSwaVxmnRCz/lK3Rc10rpqDCEOJZlhBnK
         tsZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697991643; x=1698596443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3w20SDE19R7M/DBYsehJexNI3rG7cUtG/NhFavJbLJk=;
        b=C/b1fD3mevJvgHfpm3KN9J2WabrbHOvuMEX7dfdSbvqDQ2c12ooGv5DoPeswBcrxYa
         /COx66KLoKjROKGue+GQ+IA5T9lrYzsyu0R1U1u+UhHRPRLfXe/J1xToiyzEwqzZ4ax+
         YSQRMRs7BBGwnrk4sk6UXEyMK2zQeDR1WaIfnR2NcOlcsUevOS1pzLv/zR3FgEV6h0Or
         CR3nHGzkrK3GlwMNX0N0v59VJZefpTFodO1bB2GIS6HHNoX78cW218zdQSzdIG/dq/LC
         Cnp2hkI7XA0ooRhJcvG2i1LAyi+7RWVx4abQ2cUWa/qY0hn0TOrBQkQB+Yvna/ZGDIzF
         DxNQ==
X-Gm-Message-State: AOJu0YyOFFozDDYW1rsYd/nuiujbKAR6qkzBpsFT8qbjdRiIVPHZFKD3
	RsJ6TqTy19xyvsqGA4qUWZ2f4wSn4UyU+3Vv
X-Google-Smtp-Source: AGHT+IFb3mPFsKXlmy2504j3v32BlEM08891YzAj9B5vYF2FFIWtYf/PfpZxRZ2LfxsgmGhNX4eD8w==
X-Received: by 2002:ae9:e912:0:b0:774:3235:4e6d with SMTP id x18-20020ae9e912000000b0077432354e6dmr6496497qkf.21.1697991643257;
        Sun, 22 Oct 2023 09:20:43 -0700 (PDT)
Received: from localhost ([2601:8c:502:14f0:d6de:9959:3c29:509b])
        by smtp.gmail.com with ESMTPSA id vq6-20020a05620a558600b0076e672f535asm2095914qkn.57.2023.10.22.09.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 09:20:43 -0700 (PDT)
Date: Sun, 22 Oct 2023 12:20:42 -0400
From: Oliver Crumrine <ozlinuxc@gmail.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: davem@davemloft.n
Subject: [PATCH net-next 07/17] Change occurences of cork to pointer
Message-ID: <f2ebee0285828524243efc13c157007327c2277a.1697989543.git.ozlinuxc@gmail.com>
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

Change two occurences of cork to a pointer in both inet_sk_reselect_saddr,
and inet_sk_rebuild_header.

Signed-off-by: Oliver Crumrine <ozlinuxc@gmail.com>
---
 net/ipv4/af_inet.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 3edfd8737715..60f693040a2c 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1263,7 +1263,7 @@ static int inet_sk_reselect_saddr(struct sock *sk)
 		daddr = inet_opt->opt.faddr;
 
 	/* Query new route. */
-	fl4 = &inet->cork.fl.u.ip4;
+	fl4 = &inet->cork->fl.u.ip4;
 	rt = ip_route_connect(fl4, daddr, 0, sk->sk_bound_dev_if,
 			      sk->sk_protocol, inet->inet_sport,
 			      inet->inet_dport, sk);
@@ -1321,7 +1321,7 @@ int inet_sk_rebuild_header(struct sock *sk)
 	if (inet_opt && inet_opt->opt.srr)
 		daddr = inet_opt->opt.faddr;
 	rcu_read_unlock();
-	fl4 = &inet->cork.fl.u.ip4;
+	fl4 = &inet->cork->fl.u.ip4;
 	rt = ip_route_output_ports(sock_net(sk), fl4, sk, daddr, inet->inet_saddr,
 				   inet->inet_dport, inet->inet_sport,
 				   sk->sk_protocol, RT_CONN_FLAGS(sk),
-- 
2.42.0



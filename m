Return-Path: <netdev+bounces-33092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E547979CB84
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 11:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F9D6281A9F
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 09:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BA1171C7;
	Tue, 12 Sep 2023 09:18:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B5A171BA
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 09:18:00 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BF1AA
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 02:17:59 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d745094c496so4900676276.1
        for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 02:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694510278; x=1695115078; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=z/g3nZoHZGLmd96ijFnvRMddDpuylcG5ujkL1OR+kQM=;
        b=hblg5yvvKSrgiQq4sFliKfnZE5R6kZJdGJehnPq/yO0YIBiDAzpnIiI/rh0CJn27TG
         AvxIn4bM9wZ8n3RN+Eig8ej8U6rGB/gy4QAykgZ2H5f+V+rkP4uI4N0Jz5m7TRQLl98i
         p3iyfwddhgJ1uRhuIRFkUQREow4oAv+07CYLjIDxjZ8Yc8RgS2h5D4FFYGu4NP3nqEjZ
         YxAwgwzsbsN0CEDkskVWCvbipDTTafeFOCfsoB5SX3v9Mvvy8xnCM28IHGkZpA9WBgQT
         82UfZcb8JzD+0yqkLls55xHkReQxa8DkL9MSBxNtWMBirg5zX5vinUJvCEIYJvYJTCAB
         Bj5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694510278; x=1695115078;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z/g3nZoHZGLmd96ijFnvRMddDpuylcG5ujkL1OR+kQM=;
        b=fqvJJXkff0TfpQOd+vjLjLDghsqUDhyRLKbU6l8tVR5I5zeg5HzsIJce3XFzq/r2yr
         cRS6FxeZ6pTKUN/PHkfAkmKfhNTT2P1PKFqs34qV6rDJhRzqz7UmeudVF19r02GcS3dN
         tH9vrb7Qj5Qx6HP/9jEiXid2Wnm+ez3FloYlpFABmhLZNYpkd9lMnZsRH8jDWdIBc7fK
         Z1zoFI13t4dOf4n2Zyl4WndxxXc9KacOpt+0SIX7nd2zaqTBzT4BM59tWbAlkXZns8CP
         hJrj2szVgM5spJLDCrXxGRw4loHv12jNNAQ+kQLQS3FYp8JEs47GZVBU4GsJaK9Cfwha
         /MKw==
X-Gm-Message-State: AOJu0YwMCKedvaH0Dj664Q6bSHjWWiAYXVfFnbZGOzz0P9kTjG07EslH
	52UN0VxCJX0VJDGrK9NgEh+I3a5lO600ig==
X-Google-Smtp-Source: AGHT+IFmCtFMxYhqinFdl7DiK3bz7x4melPkEWt3+oKtBOLhwwQCgMQUCJDl6FH+vys+kclKMp3CNEx1cXHuHQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:fc19:0:b0:d63:8364:328 with SMTP id
 v25-20020a25fc19000000b00d6383640328mr246769ybd.5.1694510278795; Tue, 12 Sep
 2023 02:17:58 -0700 (PDT)
Date: Tue, 12 Sep 2023 09:17:29 +0000
In-Reply-To: <20230912091730.1591459-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230912091730.1591459-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230912091730.1591459-10-edumazet@google.com>
Subject: [PATCH net-next 09/10] udplite: remove UDPLITE_BIT
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This flag is set but never read, we can remove it.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/udp.h | 5 ++---
 net/ipv4/udplite.c  | 1 -
 net/ipv6/udplite.c  | 1 -
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/linux/udp.h b/include/linux/udp.h
index 0cf83270a4a28cfe726744bd6d1d1892978ae60a..58156edec009636f2616b8a735945658d2982054 100644
--- a/include/linux/udp.h
+++ b/include/linux/udp.h
@@ -55,9 +55,8 @@ struct udp_sock {
 	__u8		 encap_type;	/* Is this an Encapsulation socket? */
 
 /* indicator bits used by pcflag: */
-#define UDPLITE_BIT      0x1  		/* set by udplite proto init function */
-#define UDPLITE_SEND_CC  0x2  		/* set via udplite setsockopt         */
-#define UDPLITE_RECV_CC  0x4		/* set via udplite setsocktopt        */
+#define UDPLITE_SEND_CC  0x1  		/* set via udplite setsockopt         */
+#define UDPLITE_RECV_CC  0x2		/* set via udplite setsocktopt        */
 	__u8		 pcflag;        /* marks socket as UDP-Lite if > 0    */
 	/*
 	 * Following member retains the information to create a UDP header
diff --git a/net/ipv4/udplite.c b/net/ipv4/udplite.c
index 39ecdad1b50ce5608fa84b9d838c91c8704b3427..af37af3ab727bffeebe5c41d84cb7c130f49c50d 100644
--- a/net/ipv4/udplite.c
+++ b/net/ipv4/udplite.c
@@ -21,7 +21,6 @@ EXPORT_SYMBOL(udplite_table);
 static int udplite_sk_init(struct sock *sk)
 {
 	udp_init_sock(sk);
-	udp_sk(sk)->pcflag = UDPLITE_BIT;
 	pr_warn_once("UDP-Lite is deprecated and scheduled to be removed in 2025, "
 		     "please contact the netdev mailing list\n");
 	return 0;
diff --git a/net/ipv6/udplite.c b/net/ipv6/udplite.c
index 267d491e970753a1bb16babb8fbe85cd67cd7062..a60bec9b14f14a5b2d271f9965b5fca3d2a440c8 100644
--- a/net/ipv6/udplite.c
+++ b/net/ipv6/udplite.c
@@ -17,7 +17,6 @@
 static int udplitev6_sk_init(struct sock *sk)
 {
 	udpv6_init_sock(sk);
-	udp_sk(sk)->pcflag = UDPLITE_BIT;
 	pr_warn_once("UDP-Lite is deprecated and scheduled to be removed in 2025, "
 		     "please contact the netdev mailing list\n");
 	return 0;
-- 
2.42.0.283.g2d96d420d3-goog



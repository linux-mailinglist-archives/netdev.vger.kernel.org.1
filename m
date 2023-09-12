Return-Path: <netdev+bounces-33088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F33879CB74
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 11:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD7C4281A81
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 09:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E337316409;
	Tue, 12 Sep 2023 09:17:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B55168AF
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 09:17:53 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0461EAA
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 02:17:53 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d7e7e70fa52so5050675276.0
        for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 02:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694510272; x=1695115072; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ww9ZwK327Gnntpnr3w4xZA0ihrdS/+SM4GPCgJhzoos=;
        b=szZKSc2/f2s4QUAeutEb7EAFACjeyqDLV8UBVPnlcmbvuear7slVJ5wuygbIa1+lg0
         Xw6EGFauQwXJ35xBfGGMlSXCihhJEvcAIrlTBiGAdp0SVlRFuYRAQSryyB+CRXThoxin
         DJ8YiX1mxPgRuFPEd4200nFfH40qecRFTici6IYKB39QIZ6oVJUg5jxIG4kmractiasq
         udv62KzsQo1PVkeMIE6qKHDYb+/D+u9BmUZ73yxIiaPhePPLEA8cJL2ykJ6qqOGcaXKB
         Zusujnf8pOPf2sRgpFt590rXpz5likeM1LgAapSOCTtz4y84yM9wF1//EUME7fDURYLA
         0uUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694510272; x=1695115072;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ww9ZwK327Gnntpnr3w4xZA0ihrdS/+SM4GPCgJhzoos=;
        b=uS0XEyNdbKyz3rTPjANTqHXG0dQkdeCtlbvMiN95uq17/f0TX74wO8rXGAYahONMlL
         Lm9D/jiNKhDx8IjrDlrkAhIfr9RGO8n5ElV/+s1Ay9ZDrI0glI22o9LpmomAunsvY33f
         xWwEm07v6Zo3eEs4tjYqzyqLEJ5sKWBpOthIx4W67yIyGLchg9JoM0phQ8P8GMfCEa+S
         gvwUcRN3FlCggol7zRx8y99T5hkjC/amxlzVTFkcCQLp5N7aZY8j3j0QKX+S2zlQlI/M
         jQ25m7wqa9l9rlzbAEgfGxSgQY96SRwt69qfgGelmTOKbzxm2YdVio7MBZeS8JQSotOq
         XKzg==
X-Gm-Message-State: AOJu0YxOFnPuQR/EwXo23sWDBtCT3WyF1mm07pyGEXJ/t66/4Ns6bV0b
	36qQd7yN0HApG+vBsbpHnh5Z7fPDiQ795A==
X-Google-Smtp-Source: AGHT+IFhZ4sw7d19CMbTPF7tzw3WKOGKcp1n/z+Vy/gbmO2IkhQl/bdsejzRGaKxbFO1DZEPBPuTOVPe9pXL/g==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:d7d0:0:b0:d7b:92d7:5629 with SMTP id
 o199-20020a25d7d0000000b00d7b92d75629mr279065ybg.8.1694510272221; Tue, 12 Sep
 2023 02:17:52 -0700 (PDT)
Date: Tue, 12 Sep 2023 09:17:25 +0000
In-Reply-To: <20230912091730.1591459-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230912091730.1591459-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230912091730.1591459-6-edumazet@google.com>
Subject: [PATCH net-next 05/10] udp: add missing WRITE_ONCE() around up->encap_rcv
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

UDP_ENCAP_ESPINUDP_NON_IKE setsockopt() writes over up->encap_rcv
while other cpus read it.

Fixes: 067b207b281d ("[UDP]: Cleanup UDP encapsulation code")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/udp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 1debc10a0f029e47ffe90aaff60727b6bb7309cc..db43907b9a3e8d8f05c98e6a873415e6731261f4 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2675,10 +2675,12 @@ int udp_lib_setsockopt(struct sock *sk, int level, int optname,
 		case UDP_ENCAP_ESPINUDP_NON_IKE:
 #if IS_ENABLED(CONFIG_IPV6)
 			if (sk->sk_family == AF_INET6)
-				up->encap_rcv = ipv6_stub->xfrm6_udp_encap_rcv;
+				WRITE_ONCE(up->encap_rcv,
+					   ipv6_stub->xfrm6_udp_encap_rcv);
 			else
 #endif
-				up->encap_rcv = xfrm4_udp_encap_rcv;
+				WRITE_ONCE(up->encap_rcv,
+					   xfrm4_udp_encap_rcv);
 #endif
 			fallthrough;
 		case UDP_ENCAP_L2TPINUDP:
-- 
2.42.0.283.g2d96d420d3-goog



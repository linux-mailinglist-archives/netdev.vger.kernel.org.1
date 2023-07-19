Return-Path: <netdev+bounces-19254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1629A75A099
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 23:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4094D1C21202
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 21:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFE6263AE;
	Wed, 19 Jul 2023 21:29:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300DE22EF5
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 21:29:20 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355E71FC0
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 14:29:19 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-cbcffb18afeso80780276.2
        for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 14:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689802158; x=1690406958;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2ODrYuTb22tbPtqX2KfnIrv4Vwi38vnTUGkrI64sRY4=;
        b=DwfOFKKtGU0vlJkc6zSnuBaHxdzVCUyuTdx2Jlj5FyztVqyRcSXvB1Mfl0VTv02DJM
         eg9gbkd1ETXhwOK/F9MpFEAK3Jj+M1UxnVVwMC2sJ69i8vYJPZCN2+Au8Jvlr4RPBN5Q
         tOD1G7c+yB3G8Y0OkH9xHNCGdsszaLwuYzWXEUqEbSmu64+9XDb4DH5nRjXEPTk/bpEe
         UCK7CD03w2jrFKhZ8WHaxlZz0borWo0gg6JzNLfn3frtNdO7rhyvNjNOfWOqjGJFvnLL
         bLzucAyasBJiA2zPu95IGbJTFrWn8X6qo6vImYOvE6z7ZzY1ywJJYQ5/4anXszuMmWRC
         mL9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689802158; x=1690406958;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ODrYuTb22tbPtqX2KfnIrv4Vwi38vnTUGkrI64sRY4=;
        b=X6oCstImxji+CLl6mK3LDJ5/mM9wxe74/dcPXcgCL+ki91DpPeMyj6651T4Mw/otoh
         G3lZD4k9wminVJh371poSIWaR2q5Wvfy1QJuqM1I8F5dQmu8vjrIU0bra1AEHi8M3obp
         nI6K7m9U3a37ZCXPD2tm7/ehvT/onSWizoMUwiMYa7/Bg8PNFiQjOG0vhJK/qnmm3CJQ
         56NH+wq9KAuUR6rrBiUCW2tayhB0azyXdRSAALGig7zSgtfCoY/3htAH6LD0DniBQbn+
         QcodI7DkWrm/fh6QDN2Djl5763DFKV3PswfbeqXY2DTVBhhiyvqPAA7hcZg3uMqahHSo
         LdHg==
X-Gm-Message-State: ABy/qLZqNX97iVG5JqLBpdtp4pjWbsB8Iy/ytgCqw/W6EWkkMR2KoQKZ
	v46NOTyqbtraqKuh9wAQ4rGstZ1NflsJsw==
X-Google-Smtp-Source: APBJJlEm9k9PsxIiEzxTwnpZ6dHtG1OsCZWLmia/8YJe+ugQjzFEStKhAQD0vHZbUi4jLGtlayBiVgSlbx52Vw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:868b:0:b0:c9c:67b6:328c with SMTP id
 z11-20020a25868b000000b00c9c67b6328cmr30874ybk.8.1689802158518; Wed, 19 Jul
 2023 14:29:18 -0700 (PDT)
Date: Wed, 19 Jul 2023 21:28:54 +0000
In-Reply-To: <20230719212857.3943972-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230719212857.3943972-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230719212857.3943972-9-edumazet@google.com>
Subject: [PATCH net 08/11] tcp: annotate data-races around rskq_defer_accept
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

do_tcp_getsockopt() reads rskq_defer_accept while another cpu
might change its value.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 2cf129a0c00bfef813e1f1e12cb247ef8107fa88..5beec71a5c418db65e19eb2a68ffd839d4550efc 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3594,9 +3594,9 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 
 	case TCP_DEFER_ACCEPT:
 		/* Translate value in seconds to number of retransmits */
-		icsk->icsk_accept_queue.rskq_defer_accept =
-			secs_to_retrans(val, TCP_TIMEOUT_INIT / HZ,
-					TCP_RTO_MAX / HZ);
+		WRITE_ONCE(icsk->icsk_accept_queue.rskq_defer_accept,
+			   secs_to_retrans(val, TCP_TIMEOUT_INIT / HZ,
+					   TCP_RTO_MAX / HZ));
 		break;
 
 	case TCP_WINDOW_CLAMP:
@@ -4002,8 +4002,9 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 			val = (val ? : READ_ONCE(net->ipv4.sysctl_tcp_fin_timeout)) / HZ;
 		break;
 	case TCP_DEFER_ACCEPT:
-		val = retrans_to_secs(icsk->icsk_accept_queue.rskq_defer_accept,
-				      TCP_TIMEOUT_INIT / HZ, TCP_RTO_MAX / HZ);
+		val = READ_ONCE(icsk->icsk_accept_queue.rskq_defer_accept);
+		val = retrans_to_secs(val, TCP_TIMEOUT_INIT / HZ,
+				      TCP_RTO_MAX / HZ);
 		break;
 	case TCP_WINDOW_CLAMP:
 		val = tp->window_clamp;
-- 
2.41.0.255.g8b1d071c50-goog



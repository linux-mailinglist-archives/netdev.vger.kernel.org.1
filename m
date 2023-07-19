Return-Path: <netdev+bounces-19248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C578975A092
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 23:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0072D1C2032C
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 21:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068DA25140;
	Wed, 19 Jul 2023 21:29:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9A022EF5
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 21:29:09 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE6F1FC0
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 14:29:08 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c5fc972760eso82640276.1
        for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 14:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689802148; x=1690406948;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l1iFsrAh5ZjefUHlWZlIBxo453nsj/fM96aR7K7WerQ=;
        b=bykKAH6gx74FN42ApkKQb78/CR8hHE5OYjniTFtgD8Mqc4DRIrBZyR1kGwCzUD2zCm
         pvjqPT83ypbBitZ2mQmpIHki4jigYjiPASiS5MsnTYKmT5VslTa2uTNChIBqjWKwkGe0
         Y9uxNC8aa6Rx8o98M1p3bMn/RbXzDxmALgRDDMDFbCOikhXIV/avroTemARsFpgFMjWu
         rPAPxMIPfnz/gvSzPCLkcm6U+z7CCxAoPI58zrzhI1tdDdljZ5MuyE7zKn6L5GqI724d
         JNJ34e6IzippA3mjAgzgm+glchSxbhqnSaTx0FX4cHKj59kqW3zKXS8dugpzcbEp/m7L
         Tu4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689802148; x=1690406948;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l1iFsrAh5ZjefUHlWZlIBxo453nsj/fM96aR7K7WerQ=;
        b=EbXuYFvnfrwZHQOct3waEO3LS3Yoxeyh1hQr3dV1XoQg9a0bEpJIARaSNo9Xw3jyAE
         JlGmaxeaF89bcBs07zrSjqlIt8MMPNcc1LRP/qVuF7XzJxtw/F4pJXbgE2SvEgRWQ90s
         sy+yyzySYVFm1joCCK40opZxAgXZCjmEXhNrN9QP5ZuKHAVOzXtkmstQB8vMZBAhpsPd
         WY3yhvkVXZ8IZyXtmT/60yvGoCtKdkNmUnm2O0uG2UYnrUmPt5acpZsSodUwQr+gLJn+
         8H2rThRyOnIhnNhThi8987+70rUd1xnOkH1iu395E1YwyN+4zo/0zMghEbR689dyUgg9
         dAcQ==
X-Gm-Message-State: ABy/qLYVIT0p2f8skfosJXtyWG8N3QwWDaAUbrFP9UXTTjkhYKm6KLkW
	TUjV/TsYfldC1k8GFAngOczydwkB5s8r3Q==
X-Google-Smtp-Source: APBJJlFbwI+tD0LkxrNLD0tpFLAPeaz+/wGTr6rffmlONavfFS356PowNMK0Fgt576Vt1DllYLL3uuyEcRWg5g==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:16d4:0:b0:c00:a33:7 with SMTP id
 203-20020a2516d4000000b00c000a330007mr3255ybw.8.1689802148112; Wed, 19 Jul
 2023 14:29:08 -0700 (PDT)
Date: Wed, 19 Jul 2023 21:28:48 +0000
In-Reply-To: <20230719212857.3943972-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230719212857.3943972-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230719212857.3943972-3-edumazet@google.com>
Subject: [PATCH net 02/11] tcp: annotate data-races around tp->tsoffset
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

do_tcp_getsockopt() reads tp->tsoffset while another cpu
might change its value.

Fixes: 93be6ce0e91b ("tcp: set and get per-socket timestamp")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp.c      | 4 ++--
 net/ipv4/tcp_ipv4.c | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index bd6400e1ae9f8ae595bbe759ff3dfb1bd02765e2..03ae6554c78d1e42894a8e511cef362134660aac 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3656,7 +3656,7 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 		if (!tp->repair)
 			err = -EPERM;
 		else
-			tp->tsoffset = val - tcp_time_stamp_raw();
+			WRITE_ONCE(tp->tsoffset, val - tcp_time_stamp_raw());
 		break;
 	case TCP_REPAIR_WINDOW:
 		err = tcp_repair_set_window(tp, optval, optlen);
@@ -4158,7 +4158,7 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 		break;
 
 	case TCP_TIMESTAMP:
-		val = tcp_time_stamp_raw() + tp->tsoffset;
+		val = tcp_time_stamp_raw() + READ_ONCE(tp->tsoffset);
 		break;
 	case TCP_NOTSENT_LOWAT:
 		val = tp->notsent_lowat;
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index b5c81cf5b86f7cb086c9c9619dec0c088e5d5916..0696420146369a8786f0dbab142e45aa09fbac00 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -307,8 +307,9 @@ int tcp_v4_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 						  inet->inet_daddr,
 						  inet->inet_sport,
 						  usin->sin_port));
-		tp->tsoffset = secure_tcp_ts_off(net, inet->inet_saddr,
-						 inet->inet_daddr);
+		WRITE_ONCE(tp->tsoffset,
+			   secure_tcp_ts_off(net, inet->inet_saddr,
+					     inet->inet_daddr));
 	}
 
 	inet->inet_id = get_random_u16();
-- 
2.41.0.255.g8b1d071c50-goog



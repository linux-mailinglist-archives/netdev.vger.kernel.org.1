Return-Path: <netdev+bounces-19249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5CC75A093
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 23:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCFED281015
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 21:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804AC2514D;
	Wed, 19 Jul 2023 21:29:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7480A22EF5
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 21:29:11 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594801FC0
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 14:29:10 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ca8e5f39e09so306735276.0
        for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 14:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689802149; x=1690406949;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WIxqiBaDajOV0oNNBeNhKjc+PtW8w0vqbXnHNwzzazU=;
        b=boMyEYMxUHXqMCPJeKPVmLSsl1qJG/lTDmMHMHUplAsDr43WReL/9WUTaBjCER5grO
         2zlIc4JTVBqiYQIVAMhhNccfBcDKc64X6Ku/1nqfF45ZsaFv4tqA7s2Li+BS6STGCNad
         AH4c9SkRKKlDVBNpF0Vx4ebC1K0AEmA1PADZo3H4b9wWIDAxL3eSJmOzxLlWko15CreA
         4CCOS69DOAsLTu9A4xeWIVNUch6caC31/5fgU7vnYNh7eBis7PskmLuODElDeCF02cIz
         EvabpXlLMjKZ5PV0D8gMS8fWvtcpCvLPuvlizPisuXj3osYlvKTmnyoqgf9yLP4k03RR
         r93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689802149; x=1690406949;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WIxqiBaDajOV0oNNBeNhKjc+PtW8w0vqbXnHNwzzazU=;
        b=dqArMo3NKusjMhrQlRoTAimB9Cg9VxljCDiWWWTMhP24QE/d5MpPY8ZSuUBBA//gMR
         SQXg+csVbQ/f6b2BrGd77xPC4yRTHB0mPLANfCoPO4djjv9cFEO4vzb0NwQ+5OwsLCQt
         wozyqxNIAYrbzSYTypjO+ldws+qFjwsQ19jh0Mj+zHZB049SV1wTgbNtBHz+ARAld/uV
         NsYtg6hmoIkgz/9mfQrtJoUz3mN4qTE78w2N58kDAZNqezSqK2YSyUiLpDJ5dE+SnRfg
         C/fqlozWuWeGXqugIzRTE4DyzX3ahaq3XsXy8hMPIHMzeHdONTVVO4kxST4870HKNL9k
         Q0Ng==
X-Gm-Message-State: ABy/qLbSwHYBDX30nQXs3DMSzDOLYH3qr3jwhvqyfVKs0iRTmYAwi0sd
	of0j8NXRRUJxcXRFhrSOHi6rTLutDsBS3g==
X-Google-Smtp-Source: APBJJlFfMA4EGM29mg8ZlPQu576N6uzjTXa77YY7NT/pcDd+8rx/MDzzCVpSYfAjFikAK2JC/vX1hR4NgNLzfA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a5b:349:0:b0:ceb:324c:ba8e with SMTP id
 q9-20020a5b0349000000b00ceb324cba8emr47935ybp.4.1689802149668; Wed, 19 Jul
 2023 14:29:09 -0700 (PDT)
Date: Wed, 19 Jul 2023 21:28:49 +0000
In-Reply-To: <20230719212857.3943972-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230719212857.3943972-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230719212857.3943972-4-edumazet@google.com>
Subject: [PATCH net 03/11] tcp: annotate data-races around tp->keepalive_time
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

do_tcp_getsockopt() reads tp->keepalive_time while another cpu
might change its value.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp.h | 7 +++++--
 net/ipv4/tcp.c    | 3 ++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index efaed11e691d52db0fcece85d966954763d3cfcf..ff7372410472246d372402dfdfd6391544be8259 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1515,9 +1515,12 @@ static inline int keepalive_intvl_when(const struct tcp_sock *tp)
 static inline int keepalive_time_when(const struct tcp_sock *tp)
 {
 	struct net *net = sock_net((struct sock *)tp);
+	int val;
 
-	return tp->keepalive_time ? :
-		READ_ONCE(net->ipv4.sysctl_tcp_keepalive_time);
+	/* Paired with WRITE_ONCE() in tcp_sock_set_keepidle_locked() */
+	val = READ_ONCE(tp->keepalive_time);
+
+	return val ? : READ_ONCE(net->ipv4.sysctl_tcp_keepalive_time);
 }
 
 static inline int keepalive_probes(const struct tcp_sock *tp)
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 03ae6554c78d1e42894a8e511cef362134660aac..b4f7856dfb1611f02073699ee24d48f1a6fe7b87 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3312,7 +3312,8 @@ int tcp_sock_set_keepidle_locked(struct sock *sk, int val)
 	if (val < 1 || val > MAX_TCP_KEEPIDLE)
 		return -EINVAL;
 
-	tp->keepalive_time = val * HZ;
+	/* Paired with WRITE_ONCE() in keepalive_time_when() */
+	WRITE_ONCE(tp->keepalive_time, val * HZ);
 	if (sock_flag(sk, SOCK_KEEPOPEN) &&
 	    !((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN))) {
 		u32 elapsed = keepalive_time_elapsed(tp);
-- 
2.41.0.255.g8b1d071c50-goog



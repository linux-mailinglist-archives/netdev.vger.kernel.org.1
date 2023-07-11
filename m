Return-Path: <netdev+bounces-16846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7394174EFD5
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 15:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A39E91C20EDE
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 13:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959C818C17;
	Tue, 11 Jul 2023 13:06:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C5218C02
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 13:06:21 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B3CE4D
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 06:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689080776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SM6Dln3l3j8xg3Tg92S1MqQlhpmKfV5kvtVaEQF2IiA=;
	b=Et5CNRunjR79kJAGQkyfa4MoLapFYzawh5Cp64ofC+6CsMYnqF4PqGXPbxci6BA/tMpylP
	+tQKFxYyP24JW8KXrcR3eKOyZr6OIl33wTpZXt6K8Ki6DMtF/24rqGJ5qRODEwLxCicn5x
	T3mnHyisEofhqG8olLurpRtRGyq99KQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-lEuIMdJqPhGakBECn4PSqA-1; Tue, 11 Jul 2023 09:06:15 -0400
X-MC-Unique: lEuIMdJqPhGakBECn4PSqA-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7679e5ebad2so839698185a.3
        for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 06:06:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689080774; x=1691672774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SM6Dln3l3j8xg3Tg92S1MqQlhpmKfV5kvtVaEQF2IiA=;
        b=GFu8quD55y/6rqE1d4HlwlVqrHa/4mO8vxFQBXOLSWriOFhIjWvfWLGzCkFTTwk8+v
         xu0ccQ5AflqrK1yOxTPO+NjUkz079IOdgm/PFEZU6hzxFoQw6hu8PYkblPoW+g6rFiLX
         aHI8jLEGQn9yaY1j4urlmOH+QdMd5wbaKPKEPur1YzV7etYLE6u5HQGe61Af/4/8OBpP
         oQEZJ979xTBdZGt30Ah75Yzf48B1j+51dz7ojtExhoyjfr/8hJHcgT5TuXdIH/+Q/3y3
         57fwXrbLeSMW+VVCMXnDtl8ubZK+arnb3qzxx7Y4wAPTf/9fBLQZJerPO8QnScme2RpQ
         i/xw==
X-Gm-Message-State: ABy/qLZnH8fNF7UY+Vx5w2JUA6JsQJsgmypQDgJ6LEsDO3kGJatF34qF
	tHaX44UadKHs1xP0KriSvlL5Z2k5t/9H4lt7NJqYbrmRrB7SzYk1n3W7pI0egKrPaHk3fgAX39q
	7mDzwW+q9GLofVZEG
X-Received: by 2002:a05:620a:47a2:b0:766:ff8a:d029 with SMTP id dt34-20020a05620a47a200b00766ff8ad029mr15069482qkb.17.1689080774694;
        Tue, 11 Jul 2023 06:06:14 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFX2q0I7mymQvTaakJlHhcvVLWoSBzEETV7kqeC5kaFsoVo/fxRf+qhkEs29d/KEzH0o5oSNg==
X-Received: by 2002:a05:620a:47a2:b0:766:ff8a:d029 with SMTP id dt34-20020a05620a47a200b00766ff8ad029mr15069463qkb.17.1689080774479;
        Tue, 11 Jul 2023 06:06:14 -0700 (PDT)
Received: from debian ([92.62.32.42])
        by smtp.gmail.com with ESMTPSA id x12-20020a05620a14ac00b007659935ce64sm960465qkj.71.2023.07.11.06.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 06:06:14 -0700 (PDT)
Date: Tue, 11 Jul 2023 15:06:08 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@parisplace.org>,
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Subject: [PATCH net-next 1/4] security: Constify sk in the sk_getsecid hook.
Message-ID: <980e4d705147a44b119fe30565c40e2424dce563.1689077819.git.gnault@redhat.com>
References: <cover.1689077819.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689077819.git.gnault@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The sk_getsecid hook shouldn't need to modify its socket argument.
Make it const so that callers of security_sk_classify_flow() can use a
const struct sock *.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 include/linux/lsm_hook_defs.h | 2 +-
 include/linux/security.h      | 5 +++--
 security/security.c           | 2 +-
 security/selinux/hooks.c      | 4 ++--
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 7308a1a7599b..4f2621e87634 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -316,7 +316,7 @@ LSM_HOOK(int, 0, sk_alloc_security, struct sock *sk, int family, gfp_t priority)
 LSM_HOOK(void, LSM_RET_VOID, sk_free_security, struct sock *sk)
 LSM_HOOK(void, LSM_RET_VOID, sk_clone_security, const struct sock *sk,
 	 struct sock *newsk)
-LSM_HOOK(void, LSM_RET_VOID, sk_getsecid, struct sock *sk, u32 *secid)
+LSM_HOOK(void, LSM_RET_VOID, sk_getsecid, const struct sock *sk, u32 *secid)
 LSM_HOOK(void, LSM_RET_VOID, sock_graft, struct sock *sk, struct socket *parent)
 LSM_HOOK(int, 0, inet_conn_request, const struct sock *sk, struct sk_buff *skb,
 	 struct request_sock *req)
diff --git a/include/linux/security.h b/include/linux/security.h
index 32828502f09e..994cf099d9ac 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1439,7 +1439,8 @@ int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u
 int security_sk_alloc(struct sock *sk, int family, gfp_t priority);
 void security_sk_free(struct sock *sk);
 void security_sk_clone(const struct sock *sk, struct sock *newsk);
-void security_sk_classify_flow(struct sock *sk, struct flowi_common *flic);
+void security_sk_classify_flow(const struct sock *sk,
+			       struct flowi_common *flic);
 void security_req_classify_flow(const struct request_sock *req,
 				struct flowi_common *flic);
 void security_sock_graft(struct sock*sk, struct socket *parent);
@@ -1597,7 +1598,7 @@ static inline void security_sk_clone(const struct sock *sk, struct sock *newsk)
 {
 }
 
-static inline void security_sk_classify_flow(struct sock *sk,
+static inline void security_sk_classify_flow(const struct sock *sk,
 					     struct flowi_common *flic)
 {
 }
diff --git a/security/security.c b/security/security.c
index b720424ca37d..2dfc7b9f6ed9 100644
--- a/security/security.c
+++ b/security/security.c
@@ -4396,7 +4396,7 @@ void security_sk_clone(const struct sock *sk, struct sock *newsk)
 }
 EXPORT_SYMBOL(security_sk_clone);
 
-void security_sk_classify_flow(struct sock *sk, struct flowi_common *flic)
+void security_sk_classify_flow(const struct sock *sk, struct flowi_common *flic)
 {
 	call_void_hook(sk_getsecid, sk, &flic->flowic_secid);
 }
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index d06e350fedee..2bdc48dd8670 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5167,12 +5167,12 @@ static void selinux_sk_clone_security(const struct sock *sk, struct sock *newsk)
 	selinux_netlbl_sk_security_reset(newsksec);
 }
 
-static void selinux_sk_getsecid(struct sock *sk, u32 *secid)
+static void selinux_sk_getsecid(const struct sock *sk, u32 *secid)
 {
 	if (!sk)
 		*secid = SECINITSID_ANY_SOCKET;
 	else {
-		struct sk_security_struct *sksec = sk->sk_security;
+		const struct sk_security_struct *sksec = sk->sk_security;
 
 		*secid = sksec->sid;
 	}
-- 
2.39.2



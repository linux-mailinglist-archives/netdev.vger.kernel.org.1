Return-Path: <netdev+bounces-12335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7717371D3
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 18:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D1811C20D7C
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 16:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D223E17AC4;
	Tue, 20 Jun 2023 16:30:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62F81ED37
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 16:30:42 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFDD1738
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 09:30:39 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f90b8ace97so37209305e9.2
        for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 09:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687278638; x=1689870638;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gZ3kJNWmTLtBf/BfLXDmeQlmTShgJXVFKrdZIjv8KLU=;
        b=UHwL1K4pbMTRAcfRGUYcKm0zXsepk52siFP533rGVXYBJiQhAAd4JWM0F3rAbSCzdm
         kgk/0KQZBcMUc9LI+nygZ/pjRD0BTibdmUZYu11f9ao0z0USFduLL/BKrGiLdUR8RLb7
         K5pwPQtiizLRxZPTg3PMt5B9TGCIlJ8XppzOw/70QTJZ0TzvfOtHfMEwUmNTuCGP0eUO
         OEMPcHx1Ism07UaFItz+PtnwJVoHLiWCCsEDCZv06SLcwChA90dddRfVHNjJyeLB4c63
         hTKY8ywCiXKiA3DRpR2oYqE2Zc+apJ/aXDkyaJhoxKMpAYH/bGdWTD+coOUfuOUxBJt3
         tz8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687278638; x=1689870638;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gZ3kJNWmTLtBf/BfLXDmeQlmTShgJXVFKrdZIjv8KLU=;
        b=T03fl0WcryVDoNI++3mPjmSwwSGF0t91WujRJKq81Lxbj6otLcAQGVGU7Q0hpvWoXB
         DY8FaJ8drg5akZiUrxJEB6/e+ivAGYONxvlim/A8WB22BZS2V5u6t2NJeaQ4LDOqSNEb
         bKttndP7Zen3fWbEgQQaCjVuw8x6CvVaBXp0AjI1VrL4nva72n9PsxAJw12iAX5nPICj
         eCbsNEy/QY4wGP/U0Th1lg7AcGHHIxJe/8K4Op0OkaACN7s9G4i1UbhXVEKSerSADa1B
         mqACOHCSvlj/iwSLwtQeBtocVL3Ai+y+LGI5orxyns5TQtaRPJ+lHs2BYA1e1u31QAXv
         4IdA==
X-Gm-Message-State: AC+VfDyo10mg4CpLXXOKdHiVavmfB3CGHA6FV0wHWzeZ1U68xmiohKVI
	15MboMi4TnI4ql9r5Eaf263dFw==
X-Google-Smtp-Source: ACHHUZ6CoQuNpRKsdfYXjAQuuAIEMObXvLAhvJ8oK143ah1vu4JhWWK2CE39kliH+aFxI0cd5E+NUA==
X-Received: by 2002:a7b:cbd7:0:b0:3f9:ab2:dd91 with SMTP id n23-20020a7bcbd7000000b003f90ab2dd91mr7782743wmi.27.1687278638108;
        Tue, 20 Jun 2023 09:30:38 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id y7-20020a05600c364700b003f8fbe3bf7asm12064342wmq.32.2023.06.20.09.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 09:30:37 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Tue, 20 Jun 2023 18:30:22 +0200
Subject: [PATCH net-next 9/9] mptcp: pass addr to mptcp_pm_alloc_anno_list
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-upstream-net-next-20230620-mptcp-expose-more-info-and-misc-v1-9-62b9444bfd48@tessares.net>
References: <20230620-upstream-net-next-20230620-mptcp-expose-more-info-and-misc-v1-0-62b9444bfd48@tessares.net>
In-Reply-To: <20230620-upstream-net-next-20230620-mptcp-expose-more-info-and-misc-v1-0-62b9444bfd48@tessares.net>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Matthieu Baerts <matthieu.baerts@tessares.net>, 
 Geliang Tang <geliang.tang@suse.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3179;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=ZCzZ8EKi5x6HATdIf96lUX0XdrhaBy/V/aHygwI2nHo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkkdQkII3YarV/LkRetzK0oASSiajfV0fUYKPKS
 6nO0dbzQkeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZJHUJAAKCRD2t4JPQmmg
 c+E7D/4oRFzBb+3Z8XhicZ8EJVpmjafjIkCblAMmOuq2/UD9ojIr6nxyXcDHd87FGJEWOdisZbO
 UZLi/fAXMiUfDp9LQZ2Y8IMUSravhrJC1nPWl+JGphPNtKS4s0g+09ZNOtkfmAJKK8Xt76H1D3i
 Au4/kNykdrbTaOFero2AblnVltHYCP7TDX2tWaSfpsZfmSDEiRAnKT97LAwZJwwlvRfUe6oi0zr
 +uLrOOdPKsP/SSxUKH3nN5nisHjpVXfcz6lL3oGDgwx19HddJ3y/bL/bGC/qevuN6G2FC33Psd6
 tNNwyEFsPpnjprrMMh78u8lJtBiHnBRnN72FyIEdhUcU9QW+hqAQzIH0KuXVfk3Om/U6i9YJ3O+
 aQF2x4EPNjpHmJIXcQ7P8yBhBycD1krFwijuyv0nEMzOBDVluagjzzKJdJzr4Ce/lSDofo18YTN
 WLFF3OZy2pTipel9OhHg/L2UdbPtSfz2rwPnZJvRv8r5NY/WfTfgOEOWW3L4RB2bhTHIiywG+nl
 qIIa5qRLlGGcLJu9yLhSAzc4bmupyg4auhnpFwfod2LkSM4CeWmJE5qKc4/qYY3eGLOaD6cVP9y
 fbC+xOlR0LM6sUtos2bgIy0OfE7AnjBt01xdms0qonYKg60+XUU2TjyqABkU8woxxZvUcoBNPg+
 t0UDgsRU+2zC5tA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Geliang Tang <geliang.tang@suse.com>

Pass addr parameter to mptcp_pm_alloc_anno_list() instead of entry. We
can reduce the scope, e.g. in mptcp_pm_alloc_anno_list(), we only access
"entry->addr", we can then restrict to the pointer to "addr" then.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/pm_netlink.c   | 8 ++++----
 net/mptcp/pm_userspace.c | 2 +-
 net/mptcp/protocol.h     | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index a12a87b780f6..c01a7197581d 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -341,7 +341,7 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 }
 
 bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
-			      const struct mptcp_pm_addr_entry *entry)
+			      const struct mptcp_addr_info *addr)
 {
 	struct mptcp_pm_add_entry *add_entry = NULL;
 	struct sock *sk = (struct sock *)msk;
@@ -349,7 +349,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 	lockdep_assert_held(&msk->pm.lock);
 
-	add_entry = mptcp_lookup_anno_list_by_saddr(msk, &entry->addr);
+	add_entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
 
 	if (add_entry) {
 		if (mptcp_pm_is_kernel(msk))
@@ -366,7 +366,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 	list_add(&add_entry->list, &msk->pm.anno_list);
 
-	add_entry->addr = entry->addr;
+	add_entry->addr = *addr;
 	add_entry->sock = msk;
 	add_entry->retrans_times = 0;
 
@@ -576,7 +576,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 			return;
 
 		if (local) {
-			if (mptcp_pm_alloc_anno_list(msk, local)) {
+			if (mptcp_pm_alloc_anno_list(msk, &local->addr)) {
 				__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
 				msk->pm.add_addr_signaled++;
 				mptcp_pm_announce_addr(msk, &local->addr, false);
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 47a883a16c11..b5a8aa4c1ebd 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -193,7 +193,7 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
 	lock_sock((struct sock *)msk);
 	spin_lock_bh(&msk->pm.lock);
 
-	if (mptcp_pm_alloc_anno_list(msk, &addr_val)) {
+	if (mptcp_pm_alloc_anno_list(msk, &addr_val.addr)) {
 		msk->pm.add_addr_signaled++;
 		mptcp_pm_announce_addr(msk, &addr_val.addr, false);
 		mptcp_pm_nl_addr_send_ack(msk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index bb4cacd92778..3a1a64cdeba6 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -817,7 +817,7 @@ int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 				 struct mptcp_addr_info *rem,
 				 u8 bkup);
 bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
-			      const struct mptcp_pm_addr_entry *entry);
+			      const struct mptcp_addr_info *addr);
 void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
 bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk);
 struct mptcp_pm_add_entry *

-- 
2.40.1



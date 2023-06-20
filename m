Return-Path: <netdev+bounces-12323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D289A737176
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 18:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00B621C20BCD
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 16:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304AF18013;
	Tue, 20 Jun 2023 16:25:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8E717AB3
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 16:25:02 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D978919C
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 09:24:58 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f97e08b012so29870555e9.3
        for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 09:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687278297; x=1689870297;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hkKFIXP3nMZMGbz/H4LzCpiIvuj0i5ReDDgyO4dldUo=;
        b=18coibiYCs7GzrJghsUH9DUBCsPyEVkNrkbpk0vDqcJIh9zUM0bufg9NlHs6Z9fO6r
         dMz2aY0NbwA4Nju/jfcX5KmcHhTFIfioomhCT1Pmo8qBm0DIBYntGie+3IxqZ5YImTA6
         IUR7dDB2dlVEGsKWe2TAT8JYTUYNw3hGpnyCmMQNfYGyED7i5AcZNCds8u69SX5XLtA1
         YLEzztzsZxQRzbYaJjyMeBMq9ZRS9AcBoMYcTGt6wZSkgUQ2SuKuVq1RhHxwKiqIj8+k
         WJbjRc7aOGvjn5tOZzEMSMb9F0tK8R1oJRTlTT0rdJLmrxVVx/UjxuysMsqYkxQc5wEu
         tpsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687278297; x=1689870297;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hkKFIXP3nMZMGbz/H4LzCpiIvuj0i5ReDDgyO4dldUo=;
        b=K/4bfb6AGR/jB3RV1vXclcMbwH32tmgYeupxElh/eAqrN/bEfYk4W35IAfv2omW8FG
         PQATUitEGNVCriCgWRMcxWwKMz4xPONXbXonPDceuPfkRnOM3mW4rmzlFfZ4ybjLHcMy
         uZ+x2RhIQA6h/W0ec7nJDhttVK709+h5ZFZgpfFgaroub3ZSiFACABQyojv1X6Afh1Ic
         8lg3aiiEocBJrkWBoYRJ9MLkKTucQwn43KR/FQWhz6K5prFKVHvzF9EXZwspqkKdRCkt
         VipQynQwKOpRTbwBASyH9NYSdIskFpfjbOXFYDAexqjQNhNVGV/Goc4LCjNf9HmUHHIj
         xB2g==
X-Gm-Message-State: AC+VfDzyR/HU6lv76yN5QyP8Lj829ce652TOkQ/E39SO68DyrXtCLvvX
	rQBwDgSEkFSeqqogCXHnp1ekWjWF8wvGigrBEO7bXg==
X-Google-Smtp-Source: ACHHUZ6D19ITO6vbLFwWP79kFcfvZdTYB/bmrCekR6gfLOy/7xPv/K6rlbzkrkXfngO+mYPk+ZgHMg==
X-Received: by 2002:a05:600c:2113:b0:3f9:b4b5:e000 with SMTP id u19-20020a05600c211300b003f9b4b5e000mr2986300wml.23.1687278297174;
        Tue, 20 Jun 2023 09:24:57 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id o19-20020a05600c511300b003f8fe1933e4sm15753056wms.3.2023.06.20.09.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 09:24:56 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Tue, 20 Jun 2023 18:24:21 +0200
Subject: [PATCH net 4/6] mptcp: consolidate fallback and non fallback state
 machine
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-upstream-net-20230620-misc-fixes-for-v6-4-v1-4-f36aa5eae8b9@tessares.net>
References: <20230620-upstream-net-20230620-misc-fixes-for-v6-4-v1-0-f36aa5eae8b9@tessares.net>
In-Reply-To: <20230620-upstream-net-20230620-misc-fixes-for-v6-4-v1-0-f36aa5eae8b9@tessares.net>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Matthieu Baerts <matthieu.baerts@tessares.net>, stable@vger.kernel.org
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7143;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=X1x+zUK0l1HOVh79Cqgvoe802mLCyclxUoTN2kDb43w=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkkdLUGDPzc0YG99qg/FkfAMjjoHdDODJEgDLik
 +lu8E1fYb6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZJHS1AAKCRD2t4JPQmmg
 cw3/D/sGZxhaONGAkakyjkx7pamXXh3GIk/nU00UH7+2PNeMHP/RXfZc578fPEnP0A4bi/lJl9d
 cjQBnprmJzemTZZzaDozprqlkU7Tn16Tm+KYy1t6kGHQ7OkNSePiub6QBztKo3RmYfeqAAm3EPT
 5ZAOZZGXXQb9U/X1GRQvIKw2ulHbi6gYGuvp0SAkboHVbSqPbjL5Qm2reZkxlXt5a+K291QjDzs
 qmnm2A1JE46P0BF8FHvDsBze1+MR1vy5o38Dzd3MiUFZSYH+ggwP60XZpObx2dAbqJUadr0Mxr9
 CUJJZYvd7shDEopIO8iVg1ItI/0Jytrdi/AEw58OHqwgGMIET4eDsm79nS4YPCxgFHuEJFtFoPZ
 z6bC1/ScFHYLKrWVWzGhPy+Vs3dchT9BeKeX39iHlnqEPh75L9XRM+K3J+vvTBy9KiRoqrwjtmt
 8kFGRvjRhV0rOTDau5ajNlniSpo+MBSMSUeRiloS6V1fJmtkrCFknaoEaa6SEg0aMmdC4SE2R0x
 QvTbavnPL1TOht6DYdaea9kKUudBEWXLABbWnrSnNdVLMg7FskN9eOkqGablXcRNVMDapi8CP74
 73+EQWw2ofTbGE7DnfYOY+ZA3zU221RyP75SvTSFqB2BGWVOK7iGo98lbz2bTScBRXfIBfzO5Dj
 IqOjdklVmePA4GQ==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Paolo Abeni <pabeni@redhat.com>

An orphaned msk releases the used resources via the worker,
when the latter first see the msk in CLOSED status.

If the msk status transitions to TCP_CLOSE in the release callback
invoked by the worker's final release_sock(), such instance of the
workqueue will not take any action.

Additionally the MPTCP code prevents scheduling the worker once the
socket reaches the CLOSE status: such msk resources will be leaked.

The only code path that can trigger the above scenario is the
__mptcp_check_send_data_fin() in fallback mode.

Address the issue removing the special handling of fallback socket
in __mptcp_check_send_data_fin(), consolidating the state machine
for fallback and non fallback socket.

Since non-fallback sockets do not send and do not receive data_fin,
the mptcp code can update the msk internal status to match the next
step in the SM every time data fin (ack) should be generated or
received.

As a consequence we can remove a bunch of checks for fallback from
the fastpath.

Fixes: 6e628cd3a8f7 ("mptcp: use mptcp release_cb for delayed tasks")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/protocol.c | 41 +++++++++++++++--------------------------
 net/mptcp/subflow.c  | 17 ++++++++++-------
 2 files changed, 25 insertions(+), 33 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 9a40dae31cec..27d206f7af62 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -44,7 +44,7 @@ enum {
 static struct percpu_counter mptcp_sockets_allocated ____cacheline_aligned_in_smp;
 
 static void __mptcp_destroy_sock(struct sock *sk);
-static void __mptcp_check_send_data_fin(struct sock *sk);
+static void mptcp_check_send_data_fin(struct sock *sk);
 
 DEFINE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions);
 static struct net_device mptcp_napi_dev;
@@ -424,8 +424,7 @@ static bool mptcp_pending_data_fin_ack(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
-	return !__mptcp_check_fallback(msk) &&
-	       ((1 << sk->sk_state) &
+	return ((1 << sk->sk_state) &
 		(TCPF_FIN_WAIT1 | TCPF_CLOSING | TCPF_LAST_ACK)) &&
 	       msk->write_seq == READ_ONCE(msk->snd_una);
 }
@@ -583,9 +582,6 @@ static bool mptcp_check_data_fin(struct sock *sk)
 	u64 rcv_data_fin_seq;
 	bool ret = false;
 
-	if (__mptcp_check_fallback(msk))
-		return ret;
-
 	/* Need to ack a DATA_FIN received from a peer while this side
 	 * of the connection is in ESTABLISHED, FIN_WAIT1, or FIN_WAIT2.
 	 * msk->rcv_data_fin was set when parsing the incoming options
@@ -623,7 +619,8 @@ static bool mptcp_check_data_fin(struct sock *sk)
 		}
 
 		ret = true;
-		mptcp_send_ack(msk);
+		if (!__mptcp_check_fallback(msk))
+			mptcp_send_ack(msk);
 		mptcp_close_wake_up(sk);
 	}
 	return ret;
@@ -1609,7 +1606,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 	if (!mptcp_timer_pending(sk))
 		mptcp_reset_timer(sk);
 	if (do_check_data_fin)
-		__mptcp_check_send_data_fin(sk);
+		mptcp_check_send_data_fin(sk);
 }
 
 static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool first)
@@ -2680,8 +2677,6 @@ static void mptcp_worker(struct work_struct *work)
 	if (unlikely((1 << state) & (TCPF_CLOSE | TCPF_LISTEN)))
 		goto unlock;
 
-	mptcp_check_data_fin_ack(sk);
-
 	mptcp_check_fastclose(msk);
 
 	mptcp_pm_nl_work(msk);
@@ -2689,7 +2684,8 @@ static void mptcp_worker(struct work_struct *work)
 	if (test_and_clear_bit(MPTCP_WORK_EOF, &msk->flags))
 		mptcp_check_for_eof(msk);
 
-	__mptcp_check_send_data_fin(sk);
+	mptcp_check_send_data_fin(sk);
+	mptcp_check_data_fin_ack(sk);
 	mptcp_check_data_fin(sk);
 
 	if (test_and_clear_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags))
@@ -2828,6 +2824,12 @@ void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, int how)
 			pr_debug("Fallback");
 			ssk->sk_shutdown |= how;
 			tcp_shutdown(ssk, how);
+
+			/* simulate the data_fin ack reception to let the state
+			 * machine move forward
+			 */
+			WRITE_ONCE(mptcp_sk(sk)->snd_una, mptcp_sk(sk)->snd_nxt);
+			mptcp_schedule_work(sk);
 		} else {
 			pr_debug("Sending DATA_FIN on subflow %p", ssk);
 			tcp_send_ack(ssk);
@@ -2867,7 +2869,7 @@ static int mptcp_close_state(struct sock *sk)
 	return next & TCP_ACTION_FIN;
 }
 
-static void __mptcp_check_send_data_fin(struct sock *sk)
+static void mptcp_check_send_data_fin(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_sock *msk = mptcp_sk(sk);
@@ -2885,19 +2887,6 @@ static void __mptcp_check_send_data_fin(struct sock *sk)
 
 	WRITE_ONCE(msk->snd_nxt, msk->write_seq);
 
-	/* fallback socket will not get data_fin/ack, can move to the next
-	 * state now
-	 */
-	if (__mptcp_check_fallback(msk)) {
-		WRITE_ONCE(msk->snd_una, msk->write_seq);
-		if ((1 << sk->sk_state) & (TCPF_CLOSING | TCPF_LAST_ACK)) {
-			inet_sk_state_store(sk, TCP_CLOSE);
-			mptcp_close_wake_up(sk);
-		} else if (sk->sk_state == TCP_FIN_WAIT1) {
-			inet_sk_state_store(sk, TCP_FIN_WAIT2);
-		}
-	}
-
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *tcp_sk = mptcp_subflow_tcp_sock(subflow);
 
@@ -2917,7 +2906,7 @@ static void __mptcp_wr_shutdown(struct sock *sk)
 	WRITE_ONCE(msk->write_seq, msk->write_seq + 1);
 	WRITE_ONCE(msk->snd_data_fin_enable, 1);
 
-	__mptcp_check_send_data_fin(sk);
+	mptcp_check_send_data_fin(sk);
 }
 
 static void __mptcp_destroy_sock(struct sock *sk)
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 4688daa6b38b..d9c8b21c6076 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1749,14 +1749,16 @@ static void subflow_state_change(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 	struct sock *parent = subflow->conn;
+	struct mptcp_sock *msk;
 
 	__subflow_state_change(sk);
 
+	msk = mptcp_sk(parent);
 	if (subflow_simultaneous_connect(sk)) {
 		mptcp_propagate_sndbuf(parent, sk);
 		mptcp_do_fallback(sk);
-		mptcp_rcv_space_init(mptcp_sk(parent), sk);
-		pr_fallback(mptcp_sk(parent));
+		mptcp_rcv_space_init(msk, sk);
+		pr_fallback(msk);
 		subflow->conn_finished = 1;
 		mptcp_set_connected(parent);
 	}
@@ -1772,11 +1774,12 @@ static void subflow_state_change(struct sock *sk)
 
 	subflow_sched_work_if_closed(mptcp_sk(parent), sk);
 
-	if (__mptcp_check_fallback(mptcp_sk(parent)) &&
-	    !subflow->rx_eof && subflow_is_done(sk)) {
-		subflow->rx_eof = 1;
-		mptcp_subflow_eof(parent);
-	}
+	/* when the fallback subflow closes the rx side, trigger a 'dummy'
+	 * ingress data fin, so that the msk state will follow along
+	 */
+	if (__mptcp_check_fallback(msk) && subflow_is_done(sk) && msk->first == sk &&
+	    mptcp_update_rcv_data_fin(msk, READ_ONCE(msk->ack_seq), true))
+		mptcp_schedule_work(parent);
 }
 
 void mptcp_subflow_queue_clean(struct sock *listener_sk, struct sock *listener_ssk)

-- 
2.40.1



Return-Path: <netdev+bounces-33004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 142AE79C301
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 04:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE85D28169F
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 02:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716608F6D;
	Tue, 12 Sep 2023 02:33:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655363FE3
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 02:33:40 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C176DC7D4
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 19:33:37 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d80256afb63so7019706276.0
        for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 19:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694486016; x=1695090816; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nrVWtdPLkLVfriOfdsH3WstBOGQReQh9PV147EbOj6s=;
        b=Mp8ksh8H4Bwobd6wsVpTEQPTKFdhjhg+Hi6D9aR3U4qS8gGtWSwjop4wi5yQbqb68w
         WfOtqzuix/07haXFsH5Ag9gn3PaYo6kR8vLf3dGb2Ucft4ipeWhNQNHEEgRkTdtLx1sB
         s+S2dsve+5yXWqncGwB5GrKRTAOgNDCHAd0FeIxfP1mGjJo7agMjaifrfvvY9UyCDW4G
         mZA2PsJ56aVS3hNpDXpEhfptJwdvTkx6TVBfM2ocy407lR4vCaxibN1M3aj/rIdnVDEC
         PcXgf2omWSQpuj5p89Hd6Vc7cvHIcdoSdWVqLc6gbqQmucXt9nEYs7jh2Efe/Tl6JP0W
         65LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694486016; x=1695090816;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nrVWtdPLkLVfriOfdsH3WstBOGQReQh9PV147EbOj6s=;
        b=B7ZBytneUjg46dq0Sdo13l5hiRPtM2drgieExj33hrn5q7vP3D8tDH+2G/8zn7syCn
         p18XsvW0pkjYOqQfFdpwJII4qUkeD9cMF0laLNYPkUbSV5p/lmz+TT0u+Az+Zf/aCdpx
         HrjNtdaFOCGVXWB3vSHVy762jG3Bfwj/qrAMDnJd8a1x3OXsOt2Lv3Dz7q2AjOMvHSaz
         4etjRSfrhkRjyB160Teh/hMWvhlZXVfzBqwF82P3+BlstsW5wlDUYAi4k8hM4imXwwID
         MIbh8mDNqFVS32zQt0aMuTVl96rM90d81Ai451sUgJD9YaoWfutJvbfn0t8Gvz/1FcwO
         EG7w==
X-Gm-Message-State: AOJu0YyTuzzirpG5r/5+8PIindCyPcmffcW57hN+zFfK5523DU3zo/v1
	BFkZT5BLUd1fRtXf9ruI0KAbc9zkl6aG1Q==
X-Google-Smtp-Source: AGHT+IFkOoK+zPzt8H1f1dXXCNYFP8aJLnuE8iMQ3AUOwj2f/3eTnXX9s+zgq+68X1oda2wsuVJlWB/iTvEiNg==
X-Received: from aananthv.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:44a6])
 (user=aananthv job=sendgmr) by 2002:a25:d342:0:b0:d47:3d35:1604 with SMTP id
 e63-20020a25d342000000b00d473d351604mr36570ybf.2.1694486016643; Mon, 11 Sep
 2023 19:33:36 -0700 (PDT)
Date: Tue, 12 Sep 2023 02:33:08 +0000
In-Reply-To: <20230912023309.3013660-1-aananthv@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230912023309.3013660-1-aananthv@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230912023309.3013660-2-aananthv@google.com>
Subject: [PATCH net-next 1/2] tcp: call tcp_try_undo_recovery when an RTOd TFO
 SYNACK is ACKed
From: Aananth V <aananthv@google.com>
To: David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Aananth V <aananthv@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>
Content-Type: text/plain; charset="UTF-8"

For passive TCP Fast Open sockets that had SYN/ACK timeout and did not
send more data in SYN_RECV, upon receiving the final ACK in 3WHS, the
congestion state may awkwardly stay in CA_Loss mode unless the CA state
was undone due to TCP timestamp checks. However, if
tcp_rcv_synrecv_state_fastopen() decides not to undo, then we should
enter CA_Open, because at that point we have received an ACK covering
the retransmitted SYNACKs. Currently, the icsk_ca_state is only set to
CA_Open after we receive an ACK for a data-packet. This is because
tcp_ack does not call tcp_fastretrans_alert (and tcp_process_loss) if
!prior_packets

Note that tcp_process_loss() calls tcp_try_undo_recovery(), so having
tcp_rcv_synrecv_state_fastopen() decide that if we're in CA_Loss we
should call tcp_try_undo_recovery() is consistent with that, and
low risk.

Fixes: dad8cea7add9 ("tcp: fix TFO SYNACK undo to avoid double-timestamp-undo")
Signed-off-by: Aananth V <aananthv@google.com>
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Yuchung Cheng <ycheng@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_input.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 06fe1cf645d5..fe2ab0db2eb7 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6436,22 +6436,23 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 
 static void tcp_rcv_synrecv_state_fastopen(struct sock *sk)
 {
+	struct tcp_sock *tp = tcp_sk(sk);
 	struct request_sock *req;
 
 	/* If we are still handling the SYNACK RTO, see if timestamp ECR allows
 	 * undo. If peer SACKs triggered fast recovery, we can't undo here.
 	 */
-	if (inet_csk(sk)->icsk_ca_state == TCP_CA_Loss)
-		tcp_try_undo_loss(sk, false);
+	if (inet_csk(sk)->icsk_ca_state == TCP_CA_Loss && !tp->packets_out)
+		tcp_try_undo_recovery(sk);
 
 	/* Reset rtx states to prevent spurious retransmits_timed_out() */
-	tcp_sk(sk)->retrans_stamp = 0;
+	tp->retrans_stamp = 0;
 	inet_csk(sk)->icsk_retransmits = 0;
 
 	/* Once we leave TCP_SYN_RECV or TCP_FIN_WAIT_1,
 	 * we no longer need req so release it.
 	 */
-	req = rcu_dereference_protected(tcp_sk(sk)->fastopen_rsk,
+	req = rcu_dereference_protected(tp->fastopen_rsk,
 					lockdep_sock_is_held(sk));
 	reqsk_fastopen_remove(sk, req, false);
 
-- 
2.42.0.283.g2d96d420d3-goog



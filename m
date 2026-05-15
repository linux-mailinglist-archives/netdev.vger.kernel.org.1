Return-Path: <netdev+bounces-288428-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WA3pH0xsB2rY2gIAu9opvQ
	(envelope-from <netdev+bounces-288428-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 20:56:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CF455687C
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 20:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F211305D86D
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 18:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60E037FF7F;
	Fri, 15 May 2026 18:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YTN8QEiG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCA938423F
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 18:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778871271; cv=none; b=sc5cKXvwMqCk3DRImihu3n1QWRUbx3GpeRhA/lI1UW3K2knnj6n7+yWXoE6827XTMUGSmwHHegADJOLMI39lf8ht7gD0UTFFuhw7g11gAZAewqSud1G0yjuR9UqSxj3ZWDnoU0PXGouKWsk1c3UYnbhKFOhqdh6DRmHDsw/bcCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778871271; c=relaxed/simple;
	bh=5eaIm7oQrXrv26FV2waWzgjgidPzic9XkF5iTxDoZAA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kBYWAFvI27IAYSj9kxFVnCN3tvsVZbGXfccgoICRfQwprMKpo8N/t+HioNxWcxo22ogvqzUu/w8z4cNdfiSgWIcxQdl9RHEAa7YDZJoRf+Ii9pdlCP3Onkpqs41t1vjjuP+v+HckwWHY1BqYMmS5vjIwzs2p5FhpqiDLusEeo8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YTN8QEiG; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4891ca4ce02so2705e9.1
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 11:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778871265; x=1779476065; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PNFlWNxHBBoOTkz1i9JncC0yIj0DqDbA8cq/UI1Bf44=;
        b=YTN8QEiGHHdnprLQd4QF4cecW35GhQVlLJOKOfrlbUIpLU3YETnSZ7SAZ75pD4+xLU
         JE95jMSsbzu7tvXxTEblYm67ZGMfe/XDBqYu9l9KCvf94QEbwgn2mVSnf+QDmBdO6yUu
         /JOROf/9RRxy4kRG2d2LLjwPrLrWHvN98DT8Q3xowg5Z5J4Q3BrqkQT6/2faP8j/N7Ei
         Bkmoa7IdWTvOBsy91glQdiElDn7pmakZxbVgrfE5WsA1HFEnVXh9HICSaz3ZGAusL6aT
         x5ftNRrsF4nOV+5ATj3tUzsa8cqi5nQRNxo4u2VEaaPgDJlirOcYBlnOy7ES2iFNLF+o
         f8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778871265; x=1779476065;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PNFlWNxHBBoOTkz1i9JncC0yIj0DqDbA8cq/UI1Bf44=;
        b=JGqeO0CDxCS67fo81EHJwUCPXrT7JXpu+mnVDTeVr/Xws/yhs41aRNWQ2Z/Lct87Zs
         riV8UI7V28B/+BKdkXePpN6uPr+XonwUPMLBpqRC/DimhWQrQYq/OntONMzNAKv4+1VA
         utQh0FOTWtRn1zTa/X3xbFMX2rlN27t5q/Q6VniOYHzg5Di3e6yJilSNnWExXi6+NlTk
         9UDyY+DyUeV/miWHlSoG35dxGuuO8DV9gvu9hZ99lYLdRE3ykrcZLvdO6RQdo+Orbav/
         x0lug9y1JuvuJCZ4DaHTwcfi52D7HDdLP+52IJYQiqhiHctdaprjuUDi358Sa93QfCld
         eRaA==
X-Forwarded-Encrypted: i=1; AFNElJ/FXS3v/lnCAboSs30zesZ2jUWJiZWHmIN0Lnzebe5Cz/jEgD/2Hyz9+e5TRZoyvimj5o9l5Qw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwUW6DgvvN5MMY89RShaSpwpwVX7jNacgOo/Dfg++q9LS6D+Rv
	f2/hLiIfofwXWR1WnhBKVZVwxp4WuSX5H3IcqGlz6nHAoYZmTI5PwkdVY497Ed12nA==
X-Gm-Gg: Acq92OGrmih8aeiwswK5/E8d6UyEjjSAg8hbDlDOKhfjYhy9bwlOibYbAfkDRPsv8mn
	gpgxXLgy4DGm60evj6mziesGErLzkfOAj74nK3UV8yeF3WDbJ0JaKMlmNUw6gJdSl+5KEtrs/Qb
	fYKgE+qgB9x1hKcWXq/kR6+tt11SzV7TKAKcUgC9cH5suE34Ot7MNx2pKIyvDn3M/ljazIctNgb
	PowMTQTu72cpUWOW+qq8ogmdLidjunzPHv/Dm1bXcMgLptXEa+VNKoDZA4bwILbeo9bsqNV8olS
	vuYwDyJIJHBaZYWy3fyojQ6cdOYaI75iduBUV8GgkgHPVh9hbuF5vA/QJ+ahUDTt9bPczjeBBnM
	Aszbuvi6YOKpPUcJJ1OLwvHxfZtVEIUoim6LpT5PF0gkluTo2X3sZQnYYJ86qkAcm+IHloOZQLc
	7T866UuH7U5hBi3VD7GQdIfV8TQcBTUYVfVOzqBU/n5/sIMbd+o0KV+p+9Ht0mMw==
X-Received: by 2002:a05:600c:605a:b0:48a:55dc:9c1e with SMTP id 5b1f17b1804b1-48ff4b2c3bfmr64135e9.10.1778871264521;
        Fri, 15 May 2026 11:54:24 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:7481:4dac:8e80:6e9b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe79ce3sm20112695e9.31.2026.05.15.11.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 11:54:24 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Fri, 15 May 2026 20:54:09 +0200
Subject: [PATCH 2/3] af_unix: Simplify unix_stream_data_wait()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-unix-recv-wait-v1-2-76adb5f063d5@google.com>
References: <20260515-unix-recv-wait-v1-0-76adb5f063d5@google.com>
In-Reply-To: <20260515-unix-recv-wait-v1-0-76adb5f063d5@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: Hannes Frederic Sowa <hannes@stressinduktion.org>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778871255; l=4212;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=5eaIm7oQrXrv26FV2waWzgjgidPzic9XkF5iTxDoZAA=;
 b=6VwkbRKbXyM57UZcd+u9NRFFl6a2vqKgQ5vgB5wq6NdR+FNOk105mWuSrcOwz+9Bf2Z+LL7U7
 XiNleUuhKGzCWlSfUq4kCilsFmjn9b9WtFSLwY6wfd01XIiUGPC3fl7
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=
X-Rspamd-Queue-Id: E5CF455687C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[google.com:+];
	TAGGED_FROM(0.00)[bounces-288428-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jannh@google.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The current implementation of unix_stream_data_wait() works like this:

 - unix_stream_read_generic() grabs locks
 - unix_stream_read_generic() determines that the read must block
 - unix_stream_read_generic() drops locks
 - unix_stream_data_wait() sets up a wait_queue_entry
 - unix_stream_data_wait() rechecks that the read must still block, with
   less locking protection than unix_stream_read_generic()
 - unix_stream_data_wait() waits, then loops back to recheck again

That seems needlessly complicated; and it also involves an ugly comparison
between a potentially-dangling `last` pointer and another
potentially-dangling `tail` pointer.

Instead, let's set up a wait_queue_entry
while the locks grabbed by unix_stream_read_generic() are still held, and
after the wait, directly retry the read.

Signed-off-by: Jann Horn <jannh@google.com>
---
 net/unix/af_unix.c | 49 ++++++++++++++-----------------------------------
 1 file changed, 14 insertions(+), 35 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index dc71ed79be4a..b38804e2c5ac 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2710,39 +2710,22 @@ static int unix_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 /*
  *	Sleep until more data has arrived. But check for races..
  */
-static long unix_stream_data_wait(struct sock *sk, long timeo,
-				  struct sk_buff *last, bool freezable)
+static long unix_stream_data_wait(struct sock *sk, long timeo, bool freezable)
+__releases(&unix_sk(sk)->iolock)
+__releases(&unix_sk(sk)->lock)
 {
 	unsigned int state = TASK_INTERRUPTIBLE | freezable * TASK_FREEZABLE;
-	struct sk_buff *tail;
 	DEFINE_WAIT(wait);
 
-	unix_state_lock(sk);
-
-	for (;;) {
-		prepare_to_wait(sk_sleep(sk), &wait, state);
-
-		tail = skb_peek_tail(&sk->sk_receive_queue);
-		if (tail != last ||
-		    sk->sk_err ||
-		    (sk->sk_shutdown & RCV_SHUTDOWN) ||
-		    signal_pending(current) ||
-		    !timeo)
-			break;
-
-		sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
-		unix_state_unlock(sk);
-		timeo = schedule_timeout(timeo);
-		unix_state_lock(sk);
-
-		if (sock_flag(sk, SOCK_DEAD))
-			break;
+	prepare_to_wait(sk_sleep(sk), &wait, state);
+	unix_state_unlock(sk);
+	mutex_unlock(&unix_sk(sk)->iolock);
 
-		sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);
-	}
+	sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
+	timeo = schedule_timeout(timeo);
+	sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);
 
 	finish_wait(sk_sleep(sk), &wait);
-	unix_state_unlock(sk);
 	return timeo;
 }
 
@@ -2955,7 +2938,7 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 	skip = max(sk_peek_offset(sk, flags), 0);
 
 	do {
-		struct sk_buff *skb, *last;
+		struct sk_buff *skb;
 		int chunk;
 
 		unix_state_lock(sk);
@@ -2963,7 +2946,7 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 			err = -ECONNRESET;
 			goto unlock;
 		}
-		last = skb = skb_peek(&sk->sk_receive_queue);
+		skb = skb_peek(&sk->sk_receive_queue);
 
 again:
 #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
@@ -2989,15 +2972,13 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 			if (sk->sk_shutdown & RCV_SHUTDOWN)
 				goto unlock;
 
-			unix_state_unlock(sk);
 			if (!timeo) {
 				err = -EAGAIN;
-				break;
+				goto unlock;
 			}
 
-			mutex_unlock(&u->iolock);
-
-			timeo = unix_stream_data_wait(sk, timeo, last, freezable);
+			/* does unix_state_unlock() and drops u->iolock */
+			timeo = unix_stream_data_wait(sk, timeo, freezable);
 
 			if (signal_pending(current)) {
 				err = sock_intr_errno(timeo);
@@ -3013,7 +2994,6 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 
 		while (skip >= unix_skb_len(skb)) {
 			skip -= unix_skb_len(skb);
-			last = skb;
 			skb = skb_peek_next(skb, &sk->sk_receive_queue);
 			if (!skb)
 				goto again;
@@ -3087,7 +3067,6 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 				break;
 
 			skip = 0;
-			last = skb;
 			unix_state_lock(sk);
 			skb = skb_peek_next(skb, &sk->sk_receive_queue);
 			if (skb)

-- 
2.54.0.563.g4f69b47b94-goog



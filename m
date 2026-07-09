Return-Path: <netdev+bounces-306378-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6l0jO+MKUGptsQIAu9opvQ
	(envelope-from <netdev+bounces-306378-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 22:56:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AA0735995
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 22:56:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=purestorage.com header.s=google2022 header.b=Me3Akqx4;
	dmarc=pass (policy=quarantine) header.from=purestorage.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306378-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306378-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EBFAA3042F10
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 20:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422E33E1204;
	Thu,  9 Jul 2026 20:54:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F9F3E1209
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 20:54:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783630492; cv=none; b=Ac9MzRLFnUGSpSa7fX71WtZ7ppV5lHE0aMjSttPJe6VfFoD0PQY4uwmAQ/zaTusqX2EszYi1sRiNI++F1kcN2QyteSyHTD1/QdcaLJfLI21oUvw5ZrSxQP1jyicPvPPAx8cvrkdUvXENv/ngTlITPHGU6a2b1+ITb/y7YoVN5pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783630492; c=relaxed/simple;
	bh=SyfWGTMcl4P17mdCn5n4OeCVIuRU7Kp9tIt2Wsbqhc8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UZAZ7nWYEIFGgs/9VlX6xKcd446Zq7sYAmlJ0/8/KDpjsDDUOdU4/iCP5cUr+DlEu8kx4lF9LYJZsXuebY4RyhfE6Rtq5AA3WgoUnQ1q+vC+wcZVa6edL7dpsaZR9R/2vG36YvuyTYfYQ8C3L5Jkdk9dzTH8yh8DeVgwnO98OWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Me3Akqx4; arc=none smtp.client-ip=209.85.210.46
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7eb42a2f5feso144198a34.1
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 13:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1783630489; x=1784235289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BCTOoDBReCKAHUMj6cK0lZRqJka1BqG6eR2AJ3B+2nA=;
        b=Me3Akqx4jOzSwL7ySqjt4eYD+hdR3H4ynbkWSUSIl/AkVmyADwcSlEhxf2ASiIaGz0
         8Ct2wVtpq/H4A4pWUnIUg1zY5/Fyxx7exYdT4etIGpA/Cng1ksy3F6hBg29Rkq6wd8fp
         2CRZ/LQR2CWRWcAUH5SrdEEeBTQ1GA9z8T4VF1HLUNF25iN0tvA7BOeRIgxxBB3o548o
         t5jjcC+SkWa1/MLvQ0TJ9OseF2FdzR//i5pwH7rWae6XGeBeFKvvPjVHY4qvjxPlRmdj
         hUZWa6Cq17Ki2qcZtOlcAaqzgbkTCvPzXpiDsF20028BkkQXL350WY3AY6LfJNO4cBAe
         4fjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783630489; x=1784235289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BCTOoDBReCKAHUMj6cK0lZRqJka1BqG6eR2AJ3B+2nA=;
        b=DZ2D6CQmr0eUW5Y6PRPTgfOAGihva8Pf26F6APzfsVuKGWsIKhfIHDoIg3hgz4MzLh
         rUabD/LurjTRU53VRYz1ZRwnnIyfCjGVvFOkpI2pdrLzIBHYUl5kjLL0CJCzxaing4Zt
         Fiu4IpvM74L8xaRBjBsYNdae9NTkQ7Hf3jWcOpEca6NexdAWAjs52QJO2tW7R5Qbz2UN
         WYCC2du+MVvVax1GuIfvLGEcz/136G/fuB2XX3XI7MRGUEbsuNli7GrxyUvIgaxhfhHH
         2jMq1Kj2RmWOOZJyezj0WgazibTHr/D1lJJ+mLuA7YXs5MVpy+xGiDIXNq4tY4xdx0D/
         Lijg==
X-Gm-Message-State: AOJu0YyL8FQuwL7UQ3IxsQDD6sum3Yz4wZrzZ1jCBIIroKIWKnLiZsnH
	rhDIH8YZoFEUjG4llYLfT8DXyrbsSuOUBG/x6KzH2BVIVF8ZJXYwlbUvVZj9H33Ctr+CryoiCyA
	OuV7Eb1GvYzPUciocB2Gz75qC7STu5pftz30x+0+X2S/TgPI5XmYscCuGKWWWezfa8CCgu4HPtA
	dwiNEFUqaQ7b2RL7i3MfhKElPckhrOaTLISf1+BLNsVM99ZQM=
X-Gm-Gg: AfdE7ckk352LG/Ec9T+HWzXRZ7VkxCnfDUbzOy5/tMIwNs+aV3+kOLXq3aMrP7tMYko
	ofQohFhGpslxBlnrl+YCaUqKF4XQIyvTD/+1GTRPy9JY7ACU/AqjTyaUx6TbQLFPCxE8FSLH84w
	uO0X/fBzrW4XmcGHImSxrjrQYlgUxHqt5eYON/wDE1L25NEeXZ6oRz5JvIzEAfcio95UZPJ4kFj
	gz7GehDwjpbS9YM+nQ6bdICYHsZ3pc0XgkMG2E9vt11Ro7yFiKBDRawsb3z02tzsRwLe8TCMm8q
	Bza7mVml6i/A7c/NSY0qfPX5W5osqWatwvtv+e3cQ37UErd+RsgH2mcKnBUUj/kE+L+vR6/U2Nu
	fDXDeT3PgDi4Lo8CP+nUCmn2DImNaseVDpAJ6V5HlOHgh8jLHphG2ay0URVA2xlbqeMSlsD/fS2
	dOKw+DXsp9vLBqBWKqk165BNZqFouDTiLUj1/8sP7Bt7aFfLKYv90kYyVGV3zs30gsFuJcJui3c
	mA3t9rHneH0hzlTmJUWaBniPi2oK6XBECS4kiiwyEqNiFQVhaUBCBU2fgUv+RuVCrbdL3OWQuKR
	v8nj7nU34o4z+FwvwYPKXFILnoJb0602k7k=
X-Received: by 2002:a05:6820:c86:b0:6a1:50f0:ccca with SMTP id 006d021491bc7-6a36dab7cc8mr6975940eaf.63.1783630489097;
        Thu, 09 Jul 2026 13:54:49 -0700 (PDT)
Received: from dev-rjethwani.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-451916d5cebsm3059283fac.15.2026.07.09.13.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 13:54:48 -0700 (PDT)
From: Rishikesh Jethwani <rjethwani@purestorage.com>
To: netdev@vger.kernel.org
Cc: saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	sd@queasysnail.net,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	leon@kernel.org,
	andrew.gospodarek@broadcom.com,
	Rishikesh Jethwani <rjethwani@purestorage.com>
Subject: [PATCH v15 8/9] tls: device: add tracepoints for the KeyUpdate path
Date: Thu,  9 Jul 2026 14:53:24 -0600
Message-Id: <20260709205325.1591196-9-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260709205325.1591196-1-rjethwani@purestorage.com>
References: <20260709205325.1591196-1-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[purestorage.com,quarantine];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,google.com,broadcom.com,purestorage.com];
	TAGGED_FROM(0.00)[bounces-306378-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:saeedm@nvidia.com,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:borisp@nvidia.com,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:sd@queasysnail.net,m:davem@davemloft.net,m:pabeni@redhat.com,m:edumazet@google.com,m:leon@kernel.org,m:andrew.gospodarek@broadcom.com,m:rjethwani@purestorage.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[rjethwani@purestorage.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rjethwani@purestorage.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[purestorage.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[purestorage.com:from_mime,purestorage.com:email,purestorage.com:mid,purestorage.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 68AA0735995

Add four trace events covering the rekey state machine in
tls_device.c:

  tls_device_rekey_start         - rekey accepted; inflight=1 means old-key
                                   data is still queued, dev_add deferred
  tls_device_rekey_reencrypt     - old-key undo pass for a boundary record
  tls_device_rekey_done          - boundary crossed, old_aead_recv freed,
                                   deferred dev_add issued if pending
  tls_device_complete_rekey_fail - TX rekey completion failed in sendmsg;
                                   READY is left set and the next sendmsg
                                   retries

Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 net/tls/tls_device.c | 17 +++++++-
 net/tls/trace.h      | 98 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 113 insertions(+), 2 deletions(-)

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 74583433b593..aa4ef04e9c43 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -761,8 +761,14 @@ int tls_device_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 	}
 
 	/* Old-key records all ACKed; switch back to HW. */
-	if (test_bit(TLS_TX_REKEY_READY, &tls_ctx->flags))
-		tls_device_complete_rekey(sk, tls_ctx, true);
+	if (test_bit(TLS_TX_REKEY_READY, &tls_ctx->flags)) {
+		rc = tls_device_complete_rekey(sk, tls_ctx, true);
+		/* On failure the READY bit is left set; the next sendmsg
+		 * retries.
+		 */
+		if (rc)
+			trace_tls_device_complete_rekey_fail(sk, rc);
+	}
 
 	/* Use SW path if rekey is in progress (PENDING) or if HW rekey
 	 * failed (FAILED).
@@ -1244,6 +1250,9 @@ int tls_device_decrypted(struct sock *sk, struct tls_context *tls_ctx)
 				return 0;
 			}
 
+			trace_tls_device_rekey_reencrypt(sk, rec_start_seq,
+							 ctx->rekey.old_nic_boundary);
+
 			/* rekey_fixup sets decrypted flags in case if NIC clears
 			 * decrypted flags on auth failure
 			 */
@@ -1254,6 +1263,8 @@ int tls_device_decrypted(struct sock *sk, struct tls_context *tls_ctx)
 							    sw_ctx, tls_ctx);
 		}
 
+		trace_tls_device_rekey_done(sk, rec_start_seq,
+					    ctx->rekey.old_nic_boundary);
 		crypto_free_aead(ctx->rekey.old_aead_recv);
 		ctx->rekey.old_aead_recv = NULL;
 
@@ -1848,6 +1859,8 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx,
 					netdev->tlsdev_ops->tls_dev_rx_rekey_fixup;
 				context->dev_add_pending = 1;
 			}
+			trace_tls_device_rekey_start(sk, copied_seq, rcv_nxt,
+						     before(copied_seq, rcv_nxt));
 		}
 	}
 
diff --git a/net/tls/trace.h b/net/tls/trace.h
index 2d8ce4ff3265..2a90b77d75e8 100644
--- a/net/tls/trace.h
+++ b/net/tls/trace.h
@@ -192,6 +192,104 @@ TRACE_EVENT(tls_device_tx_resync_send,
 	)
 );
 
+TRACE_EVENT(tls_device_rekey_start,
+
+	TP_PROTO(struct sock *sk, u32 copied_seq, u32 nic_boundary,
+		 bool inflight),
+
+	TP_ARGS(sk, copied_seq, nic_boundary, inflight),
+
+	TP_STRUCT__entry(
+		__field(	struct sock *,	sk		)
+		__field(	u32,		copied_seq	)
+		__field(	u32,		nic_boundary	)
+		__field(	bool,		inflight	)
+	),
+
+	TP_fast_assign(
+		__entry->sk = sk;
+		__entry->copied_seq = copied_seq;
+		__entry->nic_boundary = nic_boundary;
+		__entry->inflight = inflight;
+	),
+
+	TP_printk(
+		"sk=%p copied_seq=%u nic_boundary=%u inflight=%d",
+		__entry->sk, __entry->copied_seq, __entry->nic_boundary,
+		__entry->inflight
+	)
+);
+
+TRACE_EVENT(tls_device_rekey_reencrypt,
+
+	TP_PROTO(struct sock *sk, u32 tcp_seq, u32 nic_boundary),
+
+	TP_ARGS(sk, tcp_seq, nic_boundary),
+
+	TP_STRUCT__entry(
+		__field(	struct sock *,	sk		)
+		__field(	u32,		tcp_seq		)
+		__field(	u32,		nic_boundary	)
+	),
+
+	TP_fast_assign(
+		__entry->sk = sk;
+		__entry->tcp_seq = tcp_seq;
+		__entry->nic_boundary = nic_boundary;
+	),
+
+	TP_printk(
+		"sk=%p tcp_seq=%u nic_boundary=%u",
+		__entry->sk, __entry->tcp_seq, __entry->nic_boundary
+	)
+);
+
+TRACE_EVENT(tls_device_rekey_done,
+
+	TP_PROTO(struct sock *sk, u32 tcp_seq, u32 nic_boundary),
+
+	TP_ARGS(sk, tcp_seq, nic_boundary),
+
+	TP_STRUCT__entry(
+		__field(	struct sock *,	sk		)
+		__field(	u32,		tcp_seq		)
+		__field(	u32,		nic_boundary	)
+	),
+
+	TP_fast_assign(
+		__entry->sk = sk;
+		__entry->tcp_seq = tcp_seq;
+		__entry->nic_boundary = nic_boundary;
+	),
+
+	TP_printk(
+		"sk=%p tcp_seq=%u nic_boundary=%u",
+		__entry->sk, __entry->tcp_seq, __entry->nic_boundary
+	)
+);
+
+TRACE_EVENT(tls_device_complete_rekey_fail,
+
+	TP_PROTO(struct sock *sk, int rc),
+
+	TP_ARGS(sk, rc),
+
+	TP_STRUCT__entry(
+		__field(	struct sock *,	sk	)
+		__field(	int,		rc	)
+	),
+
+	TP_fast_assign(
+		__entry->sk = sk;
+		__entry->rc = rc;
+	),
+
+	TP_printk(
+		"sk=%p rc=%d",
+		__entry->sk, __entry->rc
+	)
+);
+
 #endif /* _TLS_TRACE_H_ */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.25.1



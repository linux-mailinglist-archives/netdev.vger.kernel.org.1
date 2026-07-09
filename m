Return-Path: <netdev+bounces-306376-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zTViLcgKUGpgsQIAu9opvQ
	(envelope-from <netdev+bounces-306376-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 22:55:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5579673597E
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 22:55:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=purestorage.com header.s=google2022 header.b=O9oy3g18;
	dmarc=pass (policy=quarantine) header.from=purestorage.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306376-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306376-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6BBB43053FFF
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 20:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331893E024B;
	Thu,  9 Jul 2026 20:54:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B31B3E120E
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 20:54:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783630488; cv=none; b=g2VvLdXeDmPPu3xhuVEqweiP3SelTygL4nOfC4qNIG/krQzLxOZ6kGuW5JE0hCcv8FgQTK3JTXbz4dAdPdNotL89VWhsGwXtkhvrGRvbEluXt2iPPTwGkr7BTpFfj4z/EyOC6BpfXpRXSjOGrg1d0RSlZ1+KP9rwnnMnbYk3Koc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783630488; c=relaxed/simple;
	bh=UkA/nrONMtYhFp+cKs8IEXeMPBO96AzBdP3SUZINPZg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WWqXcwuMmQzTwZoTM/uyIg8N/YB2cNtrvE8aSkdBouHjBOFMsUEtQHZ1FlKK4ni0Iyj+Oh7IFeZ8kszrLebremXzJulUOmbTHUscBCnvyRTZ0AjGeTDSBkWGG3ekaBJIyoxDxUCekbN599EH9960jgmarQCdPYy6niXaE+2e/XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=O9oy3g18; arc=none smtp.client-ip=209.85.161.43
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6a376ad8fc0so123572eaf.0
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 13:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1783630484; x=1784235284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mzX35hO2gYId0RzjiSAERQk5CIgtDQWPyFEOTQ2SsFs=;
        b=O9oy3g189H++wzaO9W6RIo3gJy5h8dGgw+Ctybgpg8u5OzmQcToHC16Vo8Uo17vOD/
         7H10J+0m0wLzprc0uHNxJ/8jZceumKwqVgZ0KoT0kC7IAbaqpYyEpVAEaqXK+hSB/bu1
         sLBjHXQWZS4gBiNXZKDf6BK+rJMhK1V+qzZZYGo6kaV6ZNrpHpwucEToUGNAi3MtAvQL
         hNohm3+RIGLS1KfvHNZW6oW4qr473Twjn7DEyAFNlhoQhp6pWX6vNzp/BpWot5plYTUx
         ydrhTRg2PBpYy8q3bnoqVMxE8i9UA38Di7Ww8Z/sn0fHizFSDWdsNGwiiCnqVLKEg2mD
         vrow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783630484; x=1784235284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mzX35hO2gYId0RzjiSAERQk5CIgtDQWPyFEOTQ2SsFs=;
        b=V928D4ldR5fzVAa9Ywz3V0RKUxXNtaPucWt8nAQdzolOAjz7/7FBK04M2g9zg9lMRe
         hWvVu219J9sx71jjC8DQzVGK/JaGbKvBBWW4+BgDbDVaoDrTNcfBNngasIyDytSzGb/D
         kUv+mSmNzqQll7BojOK/lFgI/NQLntsBp2+dwHdtVWJLogqHsz2WXrrKuidOmQp67Ftc
         EEe/UfGTDi8BFMBkR3LERsz9qpJMVb+rni7S0Djo6n2Z0KaVcrU/JfNPChvOA3cfblsH
         NBxSolHcGxOHZL7Q3v5lEKa0c27AoFZwNOKwJCIZwGpFanbTsRu1Q+19T3NjL0MoySbV
         K19Q==
X-Gm-Message-State: AOJu0YyBQdHor9dkBuf+R4NdtOCmj+cAFkVUf1l2mmSF8nuIFiwin2V2
	jmDia7pUfWgh2e+zwN9SYTNCwXA7MAyDwZ3SVZrpI38GURfolIIPZnQ2wRqK6qvTKoZHAGp/tfX
	0qnNWNDHaEiHI98Zgt3/rwNzsqjkJFVDNRsHVBlOr7EXYgcnn5BUCqpPwvrYEh91KjClytbHHCH
	a4uJOFd0VkXfHSiPfw4ayv5seOi3GlXtIyUk7GRjUapVP2a4E=
X-Gm-Gg: AfdE7cltEsz7hMl2gmUzcoIHBUgZ7B4ZL2ajO+flRo35an2TO5LuCIXlubfoXQBQ3Ez
	nXJ/pJ6icggAtXf03FtKhlbB+yUuO8QPFIEDVU4tEnV1BS7XIUP6Q0AkJE3SUeLjhhrfPZgMcOB
	czMf5wnXHFqX50qJwGaA7uTYh6J6LZ6dqKagoRctVmL3f/N+zjAH3WK0gcQYyEhSoCWQyRdbFZA
	rLZD47mPx9Ei2fe6b9/LDLn8lf/fPPqniozz8laIyGnLsgtf2hgfXUZr9eIX8+f+m9k9F4IZfnI
	FA0eKmr9h0PQ4+GjJ533NHMAzjOFhjlRba+J9qlJEIpaXLh+Dy0pDhcNWRhE2SjLibK2cNY/uBy
	C6akiGcIh13FIh9rXkynAX6BDR50ebTx4zS/HDQnhMi/7Fe6gmRS2DwXZQb+moAD2oHs+0TrEWn
	ILgFTK/pyOY0CfR9VyiKHKCI8ECxVSRw32YS/3pDi1wfFignhU+8mZyovZN1ACpYiay/0uV0cqb
	AaEqRAWokUh+oPbfWky3EQ6jzz6xTQKEJQfAefjjk0GR7Qrdli8ENyC5AS2vlZzBf7mcC0cEcT+
	1/mVodQOTq41nKlvny2cAttsz1Y2bdrNBpM=
X-Received: by 2002:a05:6820:290e:b0:6a3:8210:4643 with SMTP id 006d021491bc7-6a382104af1mr2446222eaf.6.1783630484201;
        Thu, 09 Jul 2026 13:54:44 -0700 (PDT)
Received: from dev-rjethwani.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-451916d5cebsm3059283fac.15.2026.07.09.13.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 13:54:43 -0700 (PDT)
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
Subject: [PATCH v15 6/9] tls: device: add TX KeyUpdate support
Date: Thu,  9 Jul 2026 14:53:22 -0600
Message-Id: <20260709205325.1591196-7-rjethwani@purestorage.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,google.com,broadcom.com,purestorage.com];
	TAGGED_FROM(0.00)[bounces-306376-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,purestorage.com:from_mime,purestorage.com:email,purestorage.com:mid,purestorage.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5579673597E

The NIC key cannot be replaced while HW-offloaded records
are still unacked. tls_device_start_rekey() installs a temporary SW
context with the new key and redirects sendmsg through
tls_sw_sendmsg_locked. If no records are pending,
tls_device_complete_rekey() runs inline during setsockopt; otherwise
tls_tcp_clean_acked sets REKEY_READY once all old-key records are ACKed
and the next sendmsg completes the rekey, flushing SW records and
reinstalling HW offload at the current write_seq. A KeyUpdate
arriving while one is pending re-keys the SW AEAD in place; if the
HW reinstall fails the socket stays in SW mode (REKEY_FAILED).

Tested on Mellanox ConnectX-6 Dx (Crypto Enabled) with multiple
TLS 1.3 TX KeyUpdate cycles.

Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 include/net/tls.h             |  42 ++++
 include/uapi/linux/snmp.h     |   3 +
 net/tls/tls.h                 |   8 +-
 net/tls/tls_device.c          | 384 ++++++++++++++++++++++++++++++++--
 net/tls/tls_device_fallback.c |  24 +++
 net/tls/tls_main.c            |  81 ++++---
 net/tls/tls_proc.c            |   3 +
 net/tls/tls_sw.c              |  22 +-
 8 files changed, 526 insertions(+), 41 deletions(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index eb258bcd62bc..2c6e314355fd 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -185,6 +185,13 @@ struct tls_offload_context_tx {
 	void (*sk_destruct)(struct sock *sk);
 	struct work_struct destruct_work;
 	struct tls_context *ctx;
+
+	struct {
+		struct tls_sw_context_tx sw;	/* SW context for new key */
+		struct cipher_context tx;	/* IV, rec_seq for new key */
+		union tls_crypto_context crypto_send; /* Crypto for new key */
+	} rekey;
+
 	/* The TLS layer reserves room for driver specific state
 	 * Currently the belief is that there is not enough
 	 * driver specific state to justify another layer of indirection
@@ -209,6 +216,21 @@ enum tls_context_flags {
 	 * tls_dev_del call in tls_device_down if it happens simultaneously.
 	 */
 	TLS_RX_DEV_CLOSED = 2,
+	/* Flag for TX HW context deleted during failed rekey.
+	 * Prevents double tls_dev_del in cleanup paths.
+	 */
+	TLS_TX_DEV_CLOSED = 3,
+	/* TX rekey is pending, waiting for old-key data to be ACKed.
+	 * While set, new data uses SW path with new key, HW keeps old key
+	 * for retransmissions.
+	 */
+	TLS_TX_REKEY_PENDING = 4,
+	/* All old-key data has been ACKed, ready to install new key in HW. */
+	TLS_TX_REKEY_READY = 5,
+	/* HW rekey failed, permanently stay in SW encrypt mode.
+	 * Prevents tls_tcp_clean_acked from re-setting TLS_TX_REKEY_READY.
+	 */
+	TLS_TX_REKEY_FAILED = 6,
 };
 
 struct tls_prot_info {
@@ -257,6 +279,17 @@ struct tls_context {
 			       */
 	unsigned long flags;
 
+	struct {
+		/* TCP sequence number boundary for pending rekey.
+		 * Packets with seq < this use old key, >= use new key.
+		 */
+		u32 boundary_seq;
+
+		/* Pointers to rekey contexts for SW encryption with new key */
+		struct tls_sw_context_tx *sw_ctx;
+		struct cipher_context *cipher_ctx;
+	} rekey;
+
 	/* cache cold stuff */
 	struct proto *sk_proto;
 	struct sock *sk;
@@ -389,12 +422,18 @@ static inline struct tls_sw_context_rx *tls_sw_ctx_rx(
 static inline struct tls_sw_context_tx *tls_sw_ctx_tx(
 		const struct tls_context *tls_ctx)
 {
+	if (unlikely(tls_ctx->rekey.sw_ctx))
+		return tls_ctx->rekey.sw_ctx;
+
 	return (struct tls_sw_context_tx *)tls_ctx->priv_ctx_tx;
 }
 
 static inline struct cipher_context *tls_tx_cipher_ctx(
 		const struct tls_context *tls_ctx)
 {
+	if (unlikely(tls_ctx->rekey.cipher_ctx))
+		return tls_ctx->rekey.cipher_ctx;
+
 	return (struct cipher_context *)&tls_ctx->tx;
 }
 
@@ -510,6 +549,9 @@ struct sk_buff *tls_encrypt_skb(struct sk_buff *skb);
 #ifdef CONFIG_TLS_DEVICE
 void tls_device_sk_destruct(struct sock *sk);
 void tls_offload_tx_resync_request(struct sock *sk, u32 got_seq, u32 exp_seq);
+struct sk_buff *
+tls_validate_xmit_skb_rekey(struct sock *sk, struct net_device *dev,
+			    struct sk_buff *skb);
 
 static inline bool tls_is_sk_rx_device_offloaded(struct sock *sk)
 {
diff --git a/include/uapi/linux/snmp.h b/include/uapi/linux/snmp.h
index 49f5640092a0..119fbd49179c 100644
--- a/include/uapi/linux/snmp.h
+++ b/include/uapi/linux/snmp.h
@@ -369,6 +369,9 @@ enum
 	LINUX_MIB_TLSTXREKEYOK,			/* TlsTxRekeyOk */
 	LINUX_MIB_TLSTXREKEYERROR,		/* TlsTxRekeyError */
 	LINUX_MIB_TLSRXREKEYRECEIVED,		/* TlsRxRekeyReceived */
+	LINUX_MIB_TLSTXREKEYFALLBACK,		/* TlsTxRekeyFallback */
+	LINUX_MIB_TLSTXREKEYINPROGRESS,		/* TlsTxRekeyInProgress */
+	LINUX_MIB_TLSTXREKEYABORTED,		/* TlsTxRekeyAborted */
 	__LINUX_MIB_TLSMAX
 };
 
diff --git a/net/tls/tls.h b/net/tls/tls.h
index bf46d3471da6..6e8fafca42ca 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -157,7 +157,10 @@ void tls_update_rx_zc_capable(struct tls_context *tls_ctx);
 void tls_sw_strparser_arm(struct sock *sk, struct tls_context *ctx);
 void tls_sw_strparser_done(struct tls_context *tls_ctx);
 int tls_sw_sendmsg(struct sock *sk, struct msghdr *msg, size_t size);
+int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size);
 void tls_sw_ctx_tx_init(struct sock *sk, struct tls_sw_context_tx *sw_ctx);
+int tls_sw_drain_tx(struct sock *sk, struct tls_context *ctx);
+int tls_encrypt_async_wait(struct tls_sw_context_tx *ctx);
 void tls_sw_splice_eof(struct socket *sock);
 void tls_sw_cancel_work_tx(struct tls_context *tls_ctx);
 void tls_sw_release_resources_tx(struct sock *sk);
@@ -235,7 +238,8 @@ static inline bool tls_strp_msg_mixed_decrypted(struct tls_sw_context_rx *ctx)
 #ifdef CONFIG_TLS_DEVICE
 int tls_device_init(void);
 void tls_device_cleanup(void);
-int tls_set_device_offload(struct sock *sk);
+int tls_set_device_offload(struct sock *sk,
+			   struct tls_crypto_info *crypto_info);
 void tls_device_free_resources_tx(struct sock *sk);
 int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx);
 void tls_device_offload_cleanup_rx(struct sock *sk);
@@ -246,7 +250,7 @@ static inline int tls_device_init(void) { return 0; }
 static inline void tls_device_cleanup(void) {}
 
 static inline int
-tls_set_device_offload(struct sock *sk)
+tls_set_device_offload(struct sock *sk, struct tls_crypto_info *crypto_info)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 7a98d2f6cbd3..ef837bbd9560 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -57,8 +57,14 @@ static struct page *dummy_page;
 
 static void tls_device_free_ctx(struct tls_context *ctx)
 {
-	if (ctx->tx_conf == TLS_HW)
-		kfree(tls_offload_ctx_tx(ctx));
+	if (ctx->tx_conf == TLS_HW) {
+		struct tls_offload_context_tx *offload_ctx =
+			tls_offload_ctx_tx(ctx);
+
+		memzero_explicit(&offload_ctx->rekey,
+				 sizeof(offload_ctx->rekey));
+		kfree(offload_ctx);
+	}
 
 	if (ctx->rx_conf == TLS_HW)
 		kfree(tls_offload_ctx_rx(ctx));
@@ -79,7 +85,9 @@ static void tls_device_tx_del_task(struct work_struct *work)
 	netdev = rcu_dereference_protected(ctx->netdev,
 					   !refcount_read(&ctx->refcount));
 
-	netdev->tlsdev_ops->tls_dev_del(netdev, ctx, TLS_OFFLOAD_CTX_DIR_TX);
+	if (!test_bit(TLS_TX_DEV_CLOSED, &ctx->flags))
+		netdev->tlsdev_ops->tls_dev_del(netdev, ctx,
+						TLS_OFFLOAD_CTX_DIR_TX);
 	dev_put(netdev);
 	ctx->netdev = NULL;
 	tls_device_free_ctx(ctx);
@@ -161,10 +169,14 @@ static void tls_device_commit_start_marker(struct sock *sk,
 					struct tls_offload_context_tx *offload_ctx,
 					struct tls_record_info *start_marker_record)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(&offload_ctx->lock, flags);
 	start_marker_record->end_seq = tcp_sk(sk)->write_seq;
 	start_marker_record->len = 0;
 	start_marker_record->num_frags = 0;
 	list_add_tail_rcu(&start_marker_record->list, &offload_ctx->records_list);
+	spin_unlock_irqrestore(&offload_ctx->lock, flags);
 
 	/* TLS offload is greatly simplified if we don't send
 	 * SKBs where only part of the payload needs to be encrypted.
@@ -194,6 +206,24 @@ static void delete_all_records(struct tls_offload_context_tx *offload_ctx)
 	offload_ctx->retransmit_hint = NULL;
 }
 
+static bool tls_has_unacked_records(struct tls_offload_context_tx *offload_ctx)
+{
+	struct tls_record_info *info;
+	bool has_unacked = false;
+	unsigned long flags;
+
+	spin_lock_irqsave(&offload_ctx->lock, flags);
+	list_for_each_entry(info, &offload_ctx->records_list, list) {
+		if (!tls_record_is_start_marker(info)) {
+			has_unacked = true;
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&offload_ctx->lock, flags);
+
+	return has_unacked;
+}
+
 static void tls_tcp_clean_acked(struct sock *sk, u32 acked_seq)
 {
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
@@ -222,6 +252,19 @@ static void tls_tcp_clean_acked(struct sock *sk, u32 acked_seq)
 	}
 
 	ctx->unacked_record_sn += deleted_records;
+
+	/* Once all old-key HW records are ACKed, set REKEY_READY to
+	 * let sendmsg know it can finish the rekey and switch back
+	 * to HW offload.
+	 */
+	if (test_bit(TLS_TX_REKEY_PENDING, &tls_ctx->flags) &&
+	    !test_bit(TLS_TX_REKEY_FAILED, &tls_ctx->flags)) {
+		u32 boundary_seq = READ_ONCE(tls_ctx->rekey.boundary_seq);
+
+		if (!before(acked_seq, boundary_seq))
+			set_bit(TLS_TX_REKEY_READY, &tls_ctx->flags);
+	}
+
 	spin_unlock_irqrestore(&ctx->lock, flags);
 }
 
@@ -253,6 +296,14 @@ void tls_device_free_resources_tx(struct sock *sk)
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
 
 	tls_free_partial_record(sk, tls_ctx);
+
+	if (unlikely(tls_ctx->rekey.sw_ctx))
+		tls_sw_release_resources_tx(sk);
+
+	if (test_bit(TLS_TX_REKEY_PENDING, &tls_ctx->flags)) {
+		TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYABORTED);
+		TLS_DEC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYINPROGRESS);
+	}
 }
 
 void tls_offload_tx_resync_request(struct sock *sk, u32 got_seq, u32 exp_seq)
@@ -462,6 +513,9 @@ static int tls_device_copy_data(void *addr, size_t bytes, struct iov_iter *i)
 	return 0;
 }
 
+static int tls_device_complete_rekey(struct sock *sk, struct tls_context *ctx,
+				     bool deferred);
+
 static int tls_push_data(struct sock *sk,
 			 struct iov_iter *iter,
 			 size_t size, int flags,
@@ -624,6 +678,19 @@ int tls_device_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 			goto out;
 	}
 
+	/* Old-key records all ACKed; switch back to HW. */
+	if (test_bit(TLS_TX_REKEY_READY, &tls_ctx->flags))
+		tls_device_complete_rekey(sk, tls_ctx, true);
+
+	/* Use SW path if rekey is in progress (PENDING) or if HW rekey
+	 * failed (FAILED).
+	 */
+	if (test_bit(TLS_TX_REKEY_PENDING, &tls_ctx->flags) ||
+	    test_bit(TLS_TX_REKEY_FAILED, &tls_ctx->flags)) {
+		rc = tls_sw_sendmsg_locked(sk, msg, size);
+		goto out;
+	}
+
 	rc = tls_push_data(sk, &msg->msg_iter, size, msg->msg_flags,
 			   record_type);
 
@@ -1103,6 +1170,282 @@ static struct tls_offload_context_tx *alloc_offload_ctx_tx(struct tls_context *c
 	return offload_ctx;
 }
 
+static int tls_device_init_rekey_sw(struct sock *sk,
+				    struct tls_context *ctx,
+				    struct tls_offload_context_tx *offload_ctx,
+				    struct tls_crypto_info *new_crypto_info)
+{
+	struct tls_sw_context_tx *sw_ctx = &offload_ctx->rekey.sw;
+	const struct tls_cipher_desc *cipher_desc;
+	char *key;
+	int rc;
+
+	cipher_desc = get_cipher_desc(new_crypto_info->cipher_type);
+	DEBUG_NET_WARN_ON_ONCE(!cipher_desc || !cipher_desc->offloadable);
+
+	memset(sw_ctx, 0, sizeof(*sw_ctx));
+	tls_sw_ctx_tx_init(sk, sw_ctx);
+
+	sw_ctx->aead_send = crypto_alloc_aead(cipher_desc->cipher_name, 0, 0);
+	if (IS_ERR(sw_ctx->aead_send)) {
+		rc = PTR_ERR(sw_ctx->aead_send);
+		sw_ctx->aead_send = NULL;
+		return rc;
+	}
+
+	key = crypto_info_key(new_crypto_info, cipher_desc);
+	rc = crypto_aead_setkey(sw_ctx->aead_send, key, cipher_desc->key);
+	if (rc)
+		goto free_aead;
+
+	rc = crypto_aead_setauthsize(sw_ctx->aead_send, cipher_desc->tag);
+	if (rc)
+		goto free_aead;
+
+	return 0;
+
+free_aead:
+	crypto_free_aead(sw_ctx->aead_send);
+	sw_ctx->aead_send = NULL;
+	return rc;
+}
+
+static int tls_device_start_rekey(struct sock *sk,
+				  struct tls_context *ctx,
+				  struct tls_offload_context_tx *offload_ctx,
+				  struct tls_crypto_info *new_crypto_info)
+{
+	bool rekey_pending = test_bit(TLS_TX_REKEY_PENDING, &ctx->flags);
+	bool rekey_failed = test_bit(TLS_TX_REKEY_FAILED, &ctx->flags);
+	const struct tls_cipher_desc *cipher_desc;
+	char *key, *iv, *rec_seq, *salt;
+	unsigned long flags;
+	int rc;
+
+	cipher_desc = get_cipher_desc(new_crypto_info->cipher_type);
+	DEBUG_NET_WARN_ON_ONCE(!cipher_desc || !cipher_desc->offloadable);
+
+	key = crypto_info_key(new_crypto_info, cipher_desc);
+	iv = crypto_info_iv(new_crypto_info, cipher_desc);
+	rec_seq = crypto_info_rec_seq(new_crypto_info, cipher_desc);
+	salt = crypto_info_salt(new_crypto_info, cipher_desc);
+
+	if (rekey_pending || rekey_failed) {
+		/* Wait for in-flight async encryptions submitted to this tfm
+		 * with the previous key before changing it.
+		 */
+		rc = tls_encrypt_async_wait(&offload_ctx->rekey.sw);
+		if (rc)
+			return rc;
+
+		rc = crypto_aead_setkey(offload_ctx->rekey.sw.aead_send,
+					key, cipher_desc->key);
+		if (rc)
+			return rc;
+
+		memcpy(offload_ctx->rekey.tx.iv, salt, cipher_desc->salt);
+		memcpy(offload_ctx->rekey.tx.iv + cipher_desc->salt, iv,
+		       cipher_desc->iv);
+		memcpy(offload_ctx->rekey.tx.rec_seq, rec_seq,
+		       cipher_desc->rec_seq);
+
+		if (rekey_failed) {
+			set_bit(TLS_TX_REKEY_PENDING, &ctx->flags);
+			clear_bit(TLS_TX_REKEY_FAILED, &ctx->flags);
+			TLS_DEC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXSW);
+			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXDEVICE);
+		}
+	} else {
+		/* Flush any HW open_record before switching to SW */
+		if (tls_is_pending_open_record(ctx)) {
+			rc = ctx->push_pending_record(sk, 0);
+			if (rc < 0)
+				return rc;
+		}
+
+		rc = tls_device_init_rekey_sw(sk, ctx, offload_ctx,
+					      new_crypto_info);
+		if (rc)
+			return rc;
+
+		memcpy(offload_ctx->rekey.tx.iv, salt, cipher_desc->salt);
+		memcpy(offload_ctx->rekey.tx.iv + cipher_desc->salt, iv,
+		       cipher_desc->iv);
+		memcpy(offload_ctx->rekey.tx.rec_seq, rec_seq,
+		       cipher_desc->rec_seq);
+
+		/* Prevent a partial record straddling the SW/HW boundary. */
+		tcp_write_collapse_fence(sk);
+
+		ctx->rekey.sw_ctx = &offload_ctx->rekey.sw;
+		ctx->rekey.cipher_ctx = &offload_ctx->rekey.tx;
+
+		spin_lock_irqsave(&offload_ctx->lock, flags);
+		WRITE_ONCE(ctx->rekey.boundary_seq, tcp_sk(sk)->write_seq);
+		set_bit(TLS_TX_REKEY_PENDING, &ctx->flags);
+		spin_unlock_irqrestore(&offload_ctx->lock, flags);
+
+		/* Switch to rekey validator; new sends won't use HW offload */
+		smp_store_release(&sk->sk_validate_xmit_skb,
+				  tls_validate_xmit_skb_rekey);
+	}
+
+	unsafe_memcpy(&offload_ctx->rekey.crypto_send.info, new_crypto_info,
+		      cipher_desc->crypto_info,
+		      /* checked in do_tls_setsockopt_conf */);
+	memzero_explicit(new_crypto_info, cipher_desc->crypto_info);
+
+	return 0;
+}
+
+static int tls_device_complete_rekey(struct sock *sk, struct tls_context *ctx,
+				     bool deferred)
+{
+	struct tls_offload_context_tx *offload_ctx = tls_offload_ctx_tx(ctx);
+	struct tls_record_info *start_marker_record;
+	const struct tls_cipher_desc *cipher_desc;
+	struct net_device *netdev;
+	unsigned long flags;
+	__be64 rcd_sn;
+	char *key;
+	int rc;
+
+	cipher_desc = get_cipher_desc(offload_ctx->rekey.crypto_send.info.cipher_type);
+	DEBUG_NET_WARN_ON_ONCE(!cipher_desc || !cipher_desc->offloadable);
+
+	rc = tls_sw_drain_tx(sk, ctx);
+	if (rc)
+		return rc;
+
+	start_marker_record = kmalloc_obj(*start_marker_record);
+	if (!start_marker_record)
+		return -ENOMEM;
+
+	down_read(&device_offload_lock);
+
+	netdev = rcu_dereference_protected(ctx->netdev,
+					   lockdep_is_held(&device_offload_lock));
+	if (!netdev) {
+		rc = -ENODEV;
+		goto release_lock;
+	}
+
+	if (!test_bit(TLS_TX_DEV_CLOSED, &ctx->flags)) {
+		netdev->tlsdev_ops->tls_dev_del(netdev, ctx,
+						TLS_OFFLOAD_CTX_DIR_TX);
+		set_bit(TLS_TX_DEV_CLOSED, &ctx->flags);
+	}
+
+	memcpy(crypto_info_rec_seq(&offload_ctx->rekey.crypto_send.info, cipher_desc),
+	       offload_ctx->rekey.tx.rec_seq, cipher_desc->rec_seq);
+
+	rc = tls_device_dev_add_tx(sk, netdev, &offload_ctx->rekey.crypto_send.info,
+				   tcp_sk(sk)->write_seq);
+	if (!rc)
+		clear_bit(TLS_TX_DEV_CLOSED, &ctx->flags);
+
+release_lock:
+	up_read(&device_offload_lock);
+
+	if (rc)
+		goto rekey_fail;
+
+	spin_lock_irqsave(&offload_ctx->lock, flags);
+	memcpy(&rcd_sn, offload_ctx->rekey.tx.rec_seq, sizeof(rcd_sn));
+	offload_ctx->unacked_record_sn = be64_to_cpu(rcd_sn) - 1;
+	spin_unlock_irqrestore(&offload_ctx->lock, flags);
+
+	memcpy(ctx->tx.iv, offload_ctx->rekey.tx.iv,
+	       cipher_desc->salt + cipher_desc->iv);
+	memcpy(ctx->tx.rec_seq, offload_ctx->rekey.tx.rec_seq,
+	       cipher_desc->rec_seq);
+	unsafe_memcpy(&ctx->crypto_send.info,
+		      &offload_ctx->rekey.crypto_send.info,
+		      cipher_desc->crypto_info,
+		      /* checked during rekey setup */);
+
+	key = crypto_info_key(&offload_ctx->rekey.crypto_send.info, cipher_desc);
+	rc = crypto_aead_setkey(offload_ctx->aead_send, key, cipher_desc->key);
+	if (rc)
+		goto rekey_fail;
+
+	/* Start marker: the NIC passes through everything before
+	 * write_seq unencrypted (already SW-encrypted during rekey),
+	 * same as during initial offload setup.
+	 */
+	tls_device_commit_start_marker(sk, offload_ctx, start_marker_record);
+
+	spin_lock_irqsave(&offload_ctx->lock, flags);
+	clear_bit(TLS_TX_REKEY_PENDING, &ctx->flags);
+	clear_bit(TLS_TX_REKEY_READY, &ctx->flags);
+	clear_bit(TLS_TX_REKEY_FAILED, &ctx->flags);
+	spin_unlock_irqrestore(&offload_ctx->lock, flags);
+
+	/* Switch back to HW offload validator */
+	smp_store_release(&sk->sk_validate_xmit_skb, tls_validate_xmit_skb);
+
+	crypto_free_aead(tls_sw_ctx_tx(ctx)->aead_send);
+	ctx->rekey.sw_ctx = NULL;
+	ctx->rekey.cipher_ctx = NULL;
+	memzero_explicit(&offload_ctx->rekey, sizeof(offload_ctx->rekey));
+
+	if (deferred)
+		TLS_DEC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYINPROGRESS);
+	TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYOK);
+	return 0;
+
+rekey_fail:
+	kfree(start_marker_record);
+	spin_lock_irqsave(&offload_ctx->lock, flags);
+	set_bit(TLS_TX_REKEY_FAILED, &ctx->flags);
+	clear_bit(TLS_TX_REKEY_READY, &ctx->flags);
+	clear_bit(TLS_TX_REKEY_PENDING, &ctx->flags);
+	spin_unlock_irqrestore(&offload_ctx->lock, flags);
+	if (deferred)
+		TLS_DEC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYINPROGRESS);
+	TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYFALLBACK);
+	TLS_DEC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXDEVICE);
+	TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXSW);
+
+	return 0;
+}
+
+static int tls_set_device_offload_rekey(struct sock *sk,
+					struct tls_context *ctx,
+					struct net_device *netdev,
+					struct tls_crypto_info *new_crypto_info)
+{
+	struct tls_offload_context_tx *offload_ctx = tls_offload_ctx_tx(ctx);
+	bool rekey_pending = test_bit(TLS_TX_REKEY_PENDING, &ctx->flags);
+	bool rekey_failed = test_bit(TLS_TX_REKEY_FAILED, &ctx->flags);
+	bool defer = true;
+	int rc;
+
+	if (!rekey_pending && !rekey_failed)
+		defer = tls_has_unacked_records(offload_ctx) ||
+			tls_is_pending_open_record(ctx);
+
+	down_read(&device_offload_lock);
+
+	rc = tls_device_start_rekey(sk, ctx, offload_ctx, new_crypto_info);
+	if (rc) {
+		up_read(&device_offload_lock);
+		return rc;
+	}
+
+	up_read(&device_offload_lock);
+
+	if (defer) {
+		if (!rekey_pending)
+			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYINPROGRESS);
+		else
+			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYOK);
+		return 0;
+	}
+
+	return tls_device_complete_rekey(sk, ctx, false);
+}
+
 static int tls_set_device_offload_initial(struct sock *sk,
 					  struct tls_context *ctx,
 					  struct net_device *netdev,
@@ -1187,18 +1530,23 @@ static int tls_set_device_offload_initial(struct sock *sk,
 	return rc;
 }
 
-int tls_set_device_offload(struct sock *sk)
+int tls_set_device_offload(struct sock *sk,
+			   struct tls_crypto_info *new_crypto_info)
 {
+	struct tls_crypto_info *crypto_info, *src_crypto_info;
 	const struct tls_cipher_desc *cipher_desc;
-	struct tls_crypto_info *crypto_info;
 	struct net_device *netdev;
 	struct tls_context *ctx;
 	int rc;
 
 	ctx = tls_get_ctx(sk);
 
-	if (ctx->priv_ctx_tx)
-		return -EEXIST;
+	/* Rekey is only supported for connections that are already
+	 * using HW offload. For SW offload connections, the caller
+	 * should fall back to tls_set_sw_offload() for rekey.
+	 */
+	if (new_crypto_info && ctx->tx_conf != TLS_HW)
+		return -EINVAL;
 
 	netdev = get_netdev_for_sock(sk);
 	if (!netdev) {
@@ -1212,14 +1560,20 @@ int tls_set_device_offload(struct sock *sk)
 	}
 
 	crypto_info = &ctx->crypto_send.info;
-	cipher_desc = get_cipher_desc(crypto_info->cipher_type);
+	src_crypto_info = new_crypto_info ?: crypto_info;
+	cipher_desc = get_cipher_desc(src_crypto_info->cipher_type);
 	if (!cipher_desc || !cipher_desc->offloadable) {
 		rc = -EINVAL;
 		goto release_netdev;
 	}
 
-	rc = tls_set_device_offload_initial(sk, ctx, netdev, crypto_info,
-					    cipher_desc);
+	if (new_crypto_info)
+		rc = tls_set_device_offload_rekey(sk, ctx, netdev,
+						  src_crypto_info);
+	else
+		rc = tls_set_device_offload_initial(sk, ctx, netdev,
+						    src_crypto_info,
+						    cipher_desc);
 
 release_netdev:
 	dev_put(netdev);
@@ -1352,7 +1706,10 @@ static int tls_device_down(struct net_device *netdev)
 		/* Stop offloaded TX and switch to the fallback.
 		 * tls_is_skb_tx_device_offloaded will return false.
 		 */
-		WRITE_ONCE(ctx->sk->sk_validate_xmit_skb, tls_validate_xmit_skb_sw);
+		if (!test_bit(TLS_TX_REKEY_PENDING, &ctx->flags) &&
+		    !test_bit(TLS_TX_REKEY_FAILED, &ctx->flags))
+			WRITE_ONCE(ctx->sk->sk_validate_xmit_skb,
+				   tls_validate_xmit_skb_sw);
 
 		/* Stop the RX and TX resync.
 		 * tls_dev_resync must not be called after tls_dev_del.
@@ -1369,9 +1726,12 @@ static int tls_device_down(struct net_device *netdev)
 		synchronize_net();
 
 		/* Release the offload context on the driver side. */
-		if (ctx->tx_conf == TLS_HW)
+		if (ctx->tx_conf == TLS_HW &&
+		    !test_bit(TLS_TX_DEV_CLOSED, &ctx->flags)) {
 			netdev->tlsdev_ops->tls_dev_del(netdev, ctx,
 							TLS_OFFLOAD_CTX_DIR_TX);
+			set_bit(TLS_TX_DEV_CLOSED, &ctx->flags);
+		}
 		if (ctx->rx_conf == TLS_HW &&
 		    !test_bit(TLS_RX_DEV_CLOSED, &ctx->flags))
 			netdev->tlsdev_ops->tls_dev_del(netdev, ctx,
diff --git a/net/tls/tls_device_fallback.c b/net/tls/tls_device_fallback.c
index 1110f7ac6bcb..64ac4ef4012b 100644
--- a/net/tls/tls_device_fallback.c
+++ b/net/tls/tls_device_fallback.c
@@ -435,6 +435,30 @@ struct sk_buff *tls_validate_xmit_skb_sw(struct sock *sk,
 	return tls_sw_fallback(sk, skb);
 }
 
+struct sk_buff *tls_validate_xmit_skb_rekey(struct sock *sk,
+					    struct net_device *dev,
+					    struct sk_buff *skb)
+{
+	struct tls_context *tls_ctx = tls_get_ctx(sk);
+	u32 tcp_seq = ntohl(tcp_hdr(skb)->seq);
+	u32 boundary_seq;
+
+	if (test_bit(TLS_TX_REKEY_FAILED, &tls_ctx->flags))
+		return skb;
+
+	/* If this packet is at or after the rekey boundary, it's already
+	 * SW-encrypted with the new key, pass through unchanged
+	 */
+	boundary_seq = READ_ONCE(tls_ctx->rekey.boundary_seq);
+	if (!before(tcp_seq, boundary_seq))
+		return skb;
+
+	/* Packet before boundary means retransmit of old data,
+	 * use SW fallback with the old key
+	 */
+	return tls_sw_fallback(sk, skb);
+}
+
 struct sk_buff *tls_encrypt_skb(struct sk_buff *skb)
 {
 	return tls_sw_fallback(skb->sk, skb);
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index c4c15c0e731a..b51f9ea1ed6c 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -347,8 +347,14 @@ static void tls_sk_proto_cleanup(struct sock *sk,
 		tls_sw_release_resources_tx(sk);
 		TLS_DEC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXSW);
 	} else if (ctx->tx_conf == TLS_HW) {
+		bool rekey_failed = test_bit(TLS_TX_REKEY_FAILED, &ctx->flags);
+
 		tls_device_free_resources_tx(sk);
-		TLS_DEC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXDEVICE);
+
+		if (rekey_failed)
+			TLS_DEC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXSW);
+		else
+			TLS_DEC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXDEVICE);
 	}
 
 	if (ctx->rx_conf == TLS_SW) {
@@ -369,6 +375,8 @@ static void tls_sk_proto_close(struct sock *sk, long timeout)
 
 	if (ctx->tx_conf == TLS_SW)
 		tls_sw_cancel_work_tx(ctx);
+	else if (ctx->tx_conf == TLS_HW && ctx->rekey.sw_ctx)
+		tls_sw_cancel_work_tx(ctx);
 
 	lock_sock(sk);
 	free_ctx = ctx->tx_conf != TLS_HW && ctx->rx_conf != TLS_HW;
@@ -449,8 +457,16 @@ static int do_tls_getsockopt_conf(struct sock *sk, char __user *optval,
 
 	/* get user crypto info */
 	if (tx) {
-		crypto_info = &ctx->crypto_send.info;
-		cctx = &ctx->tx;
+		if (ctx->rekey.cipher_ctx) {
+			struct tls_offload_context_tx *offload_ctx =
+				tls_offload_ctx_tx(ctx);
+
+			crypto_info = &offload_ctx->rekey.crypto_send.info;
+			cctx = &offload_ctx->rekey.tx;
+		} else {
+			crypto_info = &ctx->crypto_send.info;
+			cctx = &ctx->tx;
+		}
 	} else {
 		crypto_info = &ctx->crypto_recv.info;
 		cctx = &ctx->rx;
@@ -714,32 +730,32 @@ static int do_tls_setsockopt_conf(struct sock *sk, sockptr_t optval,
 	}
 
 	if (tx) {
-		if (update && ctx->tx_conf == TLS_HW) {
-			rc = -EOPNOTSUPP;
-			goto err_crypto_info;
-		}
-
-		if (!update) {
-			rc = tls_set_device_offload(sk);
-			conf = TLS_HW;
-			if (!rc) {
+		rc = tls_set_device_offload(sk, update ? crypto_info : NULL);
+		conf = TLS_HW;
+		if (!rc) {
+			if (!update) {
 				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXDEVICE);
 				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXDEVICE);
-				goto out;
 			}
-		}
-
-		rc = tls_set_sw_offload(sk, 1, update ? crypto_info : NULL);
-		if (rc)
+		} else if (update && ctx->tx_conf == TLS_HW) {
+			/* HW rekey failed - return the actual error.
+			 * Cannot fall back to SW for an existing HW connection.
+			 */
 			goto err_crypto_info;
-
-		if (update) {
-			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYOK);
 		} else {
-			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXSW);
-			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXSW);
+			rc = tls_set_sw_offload(sk, 1,
+						update ? crypto_info : NULL);
+			if (rc)
+				goto err_crypto_info;
+
+			if (update) {
+				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYOK);
+			} else {
+				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXSW);
+				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXSW);
+			}
+			conf = TLS_SW;
 		}
-		conf = TLS_SW;
 	} else {
 		if (update && ctx->rx_conf == TLS_HW) {
 			rc = -EOPNOTSUPP;
@@ -885,12 +901,29 @@ static int do_tls_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 
 	switch (optname) {
 	case TLS_TX:
-	case TLS_RX:
+	case TLS_RX: {
+		struct tls_context *ctx = tls_get_ctx(sk);
+		/* A HW-offload TX rekey arrives mid-stream and races with an
+		 * in-flight tls_device_sendmsg(), which holds tx_lock across
+		 * the lock_sock drop in sk_stream_wait_memory() while an
+		 * open_record is half built. start_rekey() would flush that
+		 * record and flip the SW/HW boundary under the sender,
+		 * corrupting record framing. Serialize against the data path
+		 * with tx_lock. Only the HW TX path reaches start_rekey, and
+		 * initial setup (tx_conf == BASE) has no concurrent sender.
+		 */
+		bool tx_rekey = optname == TLS_TX && ctx->tx_conf == TLS_HW;
+
+		if (tx_rekey)
+			mutex_lock(&ctx->tx_lock);
 		lock_sock(sk);
 		rc = do_tls_setsockopt_conf(sk, optval, optlen,
 					    optname == TLS_TX);
 		release_sock(sk);
+		if (tx_rekey)
+			mutex_unlock(&ctx->tx_lock);
 		break;
+	}
 	case TLS_TX_ZEROCOPY_RO:
 		lock_sock(sk);
 		rc = do_tls_setsockopt_tx_zc(sk, optval, optlen);
diff --git a/net/tls/tls_proc.c b/net/tls/tls_proc.c
index 4012c4372d4c..adca8561c7da 100644
--- a/net/tls/tls_proc.c
+++ b/net/tls/tls_proc.c
@@ -27,6 +27,9 @@ static const struct snmp_mib tls_mib_list[] = {
 	SNMP_MIB_ITEM("TlsTxRekeyOk", LINUX_MIB_TLSTXREKEYOK),
 	SNMP_MIB_ITEM("TlsTxRekeyError", LINUX_MIB_TLSTXREKEYERROR),
 	SNMP_MIB_ITEM("TlsRxRekeyReceived", LINUX_MIB_TLSRXREKEYRECEIVED),
+	SNMP_MIB_ITEM("TlsTxRekeyFallback", LINUX_MIB_TLSTXREKEYFALLBACK),
+	SNMP_MIB_ITEM("TlsTxRekeyInProgress", LINUX_MIB_TLSTXREKEYINPROGRESS),
+	SNMP_MIB_ITEM("TlsTxRekeyAborted", LINUX_MIB_TLSTXREKEYABORTED),
 };
 
 static int tls_statistics_seq_show(struct seq_file *seq, void *v)
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index b8e06b751efe..0364fae8a7e0 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -522,7 +522,7 @@ static void tls_encrypt_done(void *data, int err)
 		complete(&ctx->async_wait.completion);
 }
 
-static int tls_encrypt_async_wait(struct tls_sw_context_tx *ctx)
+int tls_encrypt_async_wait(struct tls_sw_context_tx *ctx)
 {
 	if (!atomic_dec_and_test(&ctx->encrypt_pending))
 		crypto_wait_req(-EINPROGRESS, &ctx->async_wait);
@@ -763,8 +763,7 @@ static int tls_sw_sendmsg_splice(struct sock *sk, struct msghdr *msg,
 	return 0;
 }
 
-static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
-				 size_t size)
+int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 {
 	long timeo = sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
@@ -2378,6 +2377,23 @@ void tls_sw_ctx_tx_init(struct sock *sk, struct tls_sw_context_tx *sw_ctx)
 	sw_ctx->tx_work.sk = sk;
 }
 
+int tls_sw_drain_tx(struct sock *sk, struct tls_context *ctx)
+{
+	struct tls_sw_context_tx *sw_ctx = tls_sw_ctx_tx(ctx);
+	int rc;
+
+	if (tls_is_pending_open_record(ctx))
+		tls_sw_push_pending_record(sk, 0);
+	tls_encrypt_async_wait(sw_ctx);
+	rc = tls_tx_records(sk, -1);
+	if (rc < 0 || tls_is_partially_sent_record(ctx) ||
+	    tls_is_pending_open_record(ctx))
+		return rc < 0 ? rc : -EAGAIN;
+
+	cancel_delayed_work_sync(&sw_ctx->tx_work.work);
+	return 0;
+}
+
 static bool tls_is_tx_ready(struct tls_sw_context_tx *ctx)
 {
 	struct tls_rec *rec;
-- 
2.25.1



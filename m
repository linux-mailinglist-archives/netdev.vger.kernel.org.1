Return-Path: <netdev+bounces-297997-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id w9efOcZvKmpHpQMAu9opvQ
	(envelope-from <netdev+bounces-297997-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 10:20:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4337566FCB7
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 10:20:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=Kyv0VrYb;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297997-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297997-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B2C4C300BB9C
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 08:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB253377561;
	Thu, 11 Jun 2026 08:20:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD4C3644A4
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 08:20:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781166018; cv=none; b=EP2ShfqA8N3ZjLIVZOEm3Wm8DGuBmEWhSJkcGSgpzb2YMc4cJiWozkztivoKkbURKWhRZaZTvF8dxakuS2lgJv6TSf0g+4rmdksv5HanbdaVp7v0s9dHJlXXolQ03Jecny4nmwMAlZJa7ofB3nvt0btr6kNx6uILMJxuVTZMbkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781166018; c=relaxed/simple;
	bh=PbA9cVGBPmWCqiO+IZ5dyu4zT2EJrQPkSrpH/jkjrVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PkLjOviqiaFQIKdEUoTTPc7fxLjBcRVcTeBrI1siCdRZIQ0g1kOgvzKs4/5jyJN56k/VjjJH3DGXBLWxpHLcDDpgS0gKMKc+RQSIYF4Ncm7/v3y5QUnpivIaDFjehrb8Mtwz1LSM97Ktkuc862Ac/ekCUySnhuw9w+5rSQEFjAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kyv0VrYb; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781166016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3J/CbPA1291y2zUbJKPFRYFBVcMAM9EkrwG1Dfyf1VU=;
	b=Kyv0VrYbYpG9X9ABmdibX3wBdysJQYo5BlcZ60h3GZYvZaZZ6WEnYN1JiT9fEvATk1win6
	DdmXSEHopHofgOQ/Dh/L5GiptFpNrGkTEEHU8A3W9WKT+yUjTLQvKJAYlqu0f7Xgm6XHtd
	A8/CJlmcgYoUXOCRqG25As5z68oklGA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-82-5_sXXu3wPY2Eq8xaxhF4TA-1; Thu,
 11 Jun 2026 04:20:13 -0400
X-MC-Unique: 5_sXXu3wPY2Eq8xaxhF4TA-1
X-Mimecast-MFC-AGG-ID: 5_sXXu3wPY2Eq8xaxhF4TA_1781166009
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E6BB01977000;
	Thu, 11 Jun 2026 08:20:07 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.53])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 40CFD2ED4;
	Thu, 11 Jun 2026 08:19:56 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: lucien.xin@gmail.com
Cc: netdev@vger.kernel.org,
	quic@lists.linux.dev,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	metze@samba.org,
	mbuhl@openbsd.org,
	tfanelli@redhat.com,
	hepengtao@xiaomi.com,
	dreibh@simula.no,
	linux-cifs@vger.kernel.org,
	smfrench@gmail.com,
	linkinjeon@kernel.org,
	tom@talpey.com,
	kernel-tls-handshake@lists.linux.dev,
	chuck.lever@oracle.com,
	jlayton@kernel.org,
	steved@redhat.com,
	hare@suse.de,
	aahringo@redhat.com,
	dhowells@redhat.com,
	matttbe@kernel.org,
	mail@johnericson.me,
	xiyou.wangcong@gmail.com,
	alibuda@linux.alibaba.com,
	jbaron@akamai.com,
	illiliti@protonmail.com,
	sd@queasysnail.net,
	marcelo.leitner@gmail.com,
	daniel@haxx.se,
	andrew.gospodarek@broadcom.com,
	mef@scarletmail.rutgers.edu,
	paul@jakma.org
Subject: Re: [PATCH net-next v13 12/15] quic: add crypto packet encryption and decryption
Date: Thu, 11 Jun 2026 10:19:48 +0200
Message-ID: <20260611081948.137325-1-pabeni@redhat.com>
In-Reply-To: <287e6b7dd877836e08b9bcb6727f547fe80f6459.1780855297.git.lucien.xin@gmail.com>
References: <287e6b7dd877836e08b9bcb6727f547fe80f6459.1780855297.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,davemloft.net,kernel.org,google.com,redhat.com,samba.org,openbsd.org,xiaomi.com,simula.no,gmail.com,talpey.com,oracle.com,suse.de,johnericson.me,linux.alibaba.com,akamai.com,protonmail.com,queasysnail.net,haxx.se,broadcom.com,scarletmail.rutgers.edu,jakma.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-297997-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:lucien.xin@gmail.com,m:netdev@vger.kernel.org,m:quic@lists.linux.dev,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:metze@samba.org,m:mbuhl@openbsd.org,m:tfanelli@redhat.com,m:hepengtao@xiaomi.com,m:dreibh@simula.no,m:linux-cifs@vger.kernel.org,m:smfrench@gmail.com,m:linkinjeon@kernel.org,m:tom@talpey.com,m:kernel-tls-handshake@lists.linux.dev,m:chuck.lever@oracle.com,m:jlayton@kernel.org,m:steved@redhat.com,m:hare@suse.de,m:aahringo@redhat.com,m:dhowells@redhat.com,m:matttbe@kernel.org,m:mail@johnericson.me,m:xiyou.wangcong@gmail.com,m:alibuda@linux.alibaba.com,m:jbaron@akamai.com,m:illiliti@protonmail.com,m:sd@queasysnail.net,m:marcelo.leitner@gmail.com,m:daniel@haxx.se,m:andrew.gospodarek@broadcom.com,m:mef@scarletmail.rutgers.edu,m:paul@jakma.org,m:lucienxin@gmail.com,m:xiyouwangcong@gmail.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4337566FCB7

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
quic: add crypto packet encryption and decryption

This patch adds AEAD-based packet encryption/decryption helpers, QUIC
header protection, and Retry/address-validation token generation and
verification primitives.

> diff --git a/net/quic/crypto.c b/net/quic/crypto.c
> index c68a0b570c72..77e633096c2a 100644
> --- a/net/quic/crypto.c
> +++ b/net/quic/crypto.c

[ ... ]

> +/* Retry Packet Integrity. */
> +int quic_crypto_get_retry_tag(struct quic_crypto *crypto, struct sk_buff *skb,
> +			      struct quic_conn_id *odcid, u32 version, u8 *tag)
> +{
> +	/* Reuse RX AEAD (phase 1) in Initial crypto. */
> +	struct crypto_aead *tfm = crypto->rx_tfm[1];
> +	u8 *pseudo_retry, *p, *iv, *key;
> +	DECLARE_CRYPTO_WAIT(wait);
> +	struct aead_request *req;
> +	struct scatterlist *sg;
> +	u32 plen;
> +	int err;
> +
> +	if (skb->len < QUIC_TAG_LEN)
> +		return -EINVAL;

[Low]
The guard rejects skb->len < QUIC_TAG_LEN, but a later comment in the
same function says:

> +	/* The caller must ensure skb->len > QUIC_TAG_LEN. */
> +	plen = 1 + odcid->len + skb->len - QUIC_TAG_LEN;

Should the check be <= QUIC_TAG_LEN, or should the comment say >= to
match the strict-less-than test?

In the boundary case where skb->len == QUIC_TAG_LEN, plen becomes
1 + odcid->len, and quic_put_data(p, skb->data, skb->len - QUIC_TAG_LEN)
copies zero bytes, so the integrity tag would be computed over a
pseudo-packet containing only the ODCID length and ODCID with no actual
Retry header bytes.  Is that intended?

[ ... ]

> +/* Derives a key and IV using HKDF, configures the AEAD transform and performs
> + * AEAD encryption/decryption for the provided token.
> + */
> +static int quic_crypto_token_protect(struct quic_crypto *crypto, u8 *token,
> +				     u32 len, u32 adlen, bool enc)
> +{
> +	u8 key[TLS_CIPHER_AES_GCM_128_KEY_SIZE], iv[QUIC_IV_LEN], *tiv;
> +	/* Reuse TX AEAD (phase 1) in Initial crypto. */
> +	struct crypto_aead *tfm = crypto->tx_tfm[1];
> +	u32 extra = enc ? QUIC_TAG_LEN : 0;
> +	struct quic_data srt = {}, k, i;
> +	DECLARE_CRYPTO_WAIT(wait);
> +	struct aead_request *req;
> +	struct scatterlist *sg;
> +	void *ctx = NULL;
> +	int err;
> +
> +	quic_data(&srt, quic_random_data, QUIC_RANDOM_DATA_LEN);
> +	quic_data(&k, key, TLS_CIPHER_AES_GCM_128_KEY_SIZE);
> +	quic_data(&i, iv, QUIC_IV_LEN);
> +	err = quic_crypto_keys_derive(crypto->secret_tfm, &srt, &k, &i, NULL,
> +				      QUIC_VERSION_V1);

[Critical]
Can this lead to AES-GCM nonce reuse across all generated tokens?

quic_random_data is a module-global buffer initialized once in
quic_crypto_init() via get_random_bytes() and never refreshed:

    static u8 quic_random_data[QUIC_RANDOM_DATA_LEN] __read_mostly;

quic_crypto_keys_derive() runs HKDF-Expand-Label over that constant
secret with constant labels "quic key" and "quic iv", so both the
derived key and the derived IV are deterministic and identical on every
invocation of quic_crypto_token_protect().

> +	if (err)
> +		goto out;
> +	err = crypto_aead_setauthsize(tfm, QUIC_TAG_LEN);
> +	if (err)
> +		goto out;
> +	err = crypto_aead_setkey(tfm, key, TLS_CIPHER_AES_GCM_128_KEY_SIZE);
> +	if (err)
> +		goto out;
> +	ctx = quic_crypto_aead_mem_alloc(tfm, 0, &tiv, &req, &sg, 1);
> +	if (!ctx) {
> +		err = -ENOMEM;
> +		goto out;
> +	}
> +	memcpy(tiv, iv, QUIC_IV_LEN);
> +
> +	sg_init_one(sg, token, len);
> +	aead_request_set_tfm(req, tfm);
> +	aead_request_set_ad(req, adlen);
> +	aead_request_set_crypt(req, sg, sg, len - adlen - extra, tiv);

Every call ends up using the same (K, N) pair under AES-GCM, with no
per-token random prefix and no packet-number XOR like
quic_crypto_payload_protect() does via cb->number.

NIST SP 800-38D forbids reuse of (K, N) under GCM; from two valid
ciphertexts an attacker can recover the GHASH authentication subkey H
and forge tokens for arbitrary client addresses, which would defeat
the address validation in quic_crypto_verify_token() and the
anti-amplification protections in RFC 9000 section 8.

Could a unique per-token nonce be derived (for example from a random
prefix stored in the token itself), or a nonce-misuse-resistant AEAD
be used here instead?

> +	aead_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
> +				  crypto_req_done, &wait);
> +	err = enc ? crypto_aead_encrypt(req) : crypto_aead_decrypt(req);
> +	if (err == -EINPROGRESS || err == -EBUSY)
> +		err = crypto_wait_req(err, &wait);
> +
> +out:
> +	memzero_explicit(key, sizeof(key));
> +	memzero_explicit(iv, sizeof(iv));
> +	kfree_sensitive(ctx);
> +	return err;
> +}

[ ... ]
-- 
This is an AI-generated review.



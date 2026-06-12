Return-Path: <netdev+bounces-298789-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IxuHCtRqLGqFQgQAu9opvQ
	(envelope-from <netdev+bounces-298789-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 22:23:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF6367C457
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 22:23:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ne5WEkMp;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298789-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298789-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E96F30564A8
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 20:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B75389115;
	Fri, 12 Jun 2026 20:23:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25361397682
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 20:23:43 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781295826; cv=pass; b=XKcDUi+rLJM84Ax9NYpvJaBqd3AlW+X7S6upluLDdPwWkHWKPPoQSRe6DMJH7Zg9YD6v+pvDgac8nHgVCf1tbrdE6Lmd75bI51sTHpXXqFYRxiQgrFPYmOngj/yovw2Ji5KXWO9zXgeJRKCOQ2HGD304SZHj+qWeKUGTZRWhhb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781295826; c=relaxed/simple;
	bh=j+Tw/DqvrvyTXJQnCqEunpYlqcUp4PdtpY9B1mt+aCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L/eliZz2poy00nUmuwyt6tce+C6JpVLdD4OQPOH1BaGfS7LuHErSFP6BAf6Zl1gmveB4ZR+f1f0MU6j1HJUUt3TStpPDQh6G8lBY0Kfqdk0OtSLwG27vdRUAMAahFs1WNTRE4tqjIltvz3M2q6ItrotSrWfLijyd94QxFWrYL4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ne5WEkMp; arc=pass smtp.client-ip=209.85.210.176
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-842319576d5so848980b3a.1
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 13:23:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781295823; cv=none;
        d=google.com; s=arc-20240605;
        b=O2Pe329hMlHQ5WXSEqDSbWVHz49Tn1Dwku3bLVyg2ES6C/tGRjjvuIo/87cNp7TABj
         2+kci0/NROC/Yc2vXrOsYV6fevboNnWiCpAvxcAHxKNKNYketqsxr3nYIH3D31Q8GnDg
         9j26nLM8d/lCkOfWLgpPbyq3eqw+9Wbgzju3Hlx4vws6SQ/sntyqcdS0yznvpiRrkaam
         +x4SinnPcfhIgnWiUuRX6rcT/LqC0xgieKaCKTgelJyV3PU6yhbqkIJ6IN94Fgq8lSTz
         rR6R8n1IKzERKJZHAiaowdZdSCvjRIW2BFznJB9eHGfwzz8IjWdfg165/+A6kwtRtSOs
         vLDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=axLJGxYQXY76T7E7LoVtvtvjy73/TjaCst9TPiXrWdM=;
        fh=64w4Cm65Oku8tiA/A6vBrY6EXrgvRqOIY54/EI5UbYU=;
        b=H+bMsvQNVHHBOK4EXlvs1s+sZau/MLYgL4FhGi3rT4cVaPfp1W6mcJrh40SKjnGX4/
         OnwU3MORWVWVi1cKkdHxCT4IB92QDo2aM6BcZTaE2lY5YtviJXAqMqjlfhRBg3x2+YNQ
         rPaU0tYZRUN9VNprnh8y31KVToPsXDV3pqCq54OrwbZEnUIc1YiephoKG1tWu36CnMhF
         fh4xjLOjNCuQB5diEIceV/xeJJDSIVzSF0KS7vf/0zoGyaxqz4WFPBwKREDp5t+O6fd1
         BMrYBA3tdPTbKsMeUK5UGxPvjExi5+Th7bbaH9fGphdlTOQa5VDSj6IEudvUgxIfCaNp
         fKuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781295823; x=1781900623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=axLJGxYQXY76T7E7LoVtvtvjy73/TjaCst9TPiXrWdM=;
        b=ne5WEkMp2kmHIGyDCQEuxCE9iJdd+2PuOpk7+knCPHt/uv11aD007VGhRwP//3d7SG
         mtcWpN7lUABEK5Mcx56SeTdzR71MEq785NnjESNoWweMHVz1SPPUcPrtgdV71/rIFDrF
         ddBmGvyz7KvdFXACM7Sg9S32MxsZM44nZMGdyRPy5ngHG1afwKCn5IS4YvUbhYS4yAhD
         kjnALOAFzZPhsCUvvCR958hxN+MBK8mzBveCdxs242mBFszO7/6M1KOOU3mLeKv+ob0A
         3lL8as5PYDzhRdDhFUGeic9OCrgUh5JUelItSJDoOz5FA6X8CFyVVgFArOsdRn3zOxrc
         0y7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781295823; x=1781900623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=axLJGxYQXY76T7E7LoVtvtvjy73/TjaCst9TPiXrWdM=;
        b=nfQDzGT+XRPklopFXNjqXbryR3LaMYCuGP3ad6SI24Kvn8zJVNaBjAKEb0qS0H2bkO
         XvNf9+FF18c1V1vE60lRwGgQNeCUOZkrZv9ndnq+Ac+g7XVjI5RQ8Qh+g7nSs27VMHEY
         uWlN8D6pObMnakQnfMoxipCJYyNmVsIrySfRLksyZnAGT8SjQM96RQiwCz3SzPLRydW7
         1L1jfQ5GqE9uGIrwu0NapRjWmcwxASY+76oG1C+xDm+Q4XMKjeHSVwcCHiPYXoAJSOc6
         j/iabVt2WE4uA3/cK/egywuJxvzEJAmiygQa91l8S0wj2YORl19hJBaqhBSn9xpEqJOM
         bqLg==
X-Gm-Message-State: AOJu0YxQvH7PEc+6I1m7Rl+SspfE89LiEmMxOPZzwpZOdvwNMosqt63d
	/pG4hrdyyP0RxKVX39zVgM7CnUxtej+Ckhdq348S9UMfPKLbXF4AD/vgFl1oFOI/5fnf9WouDbD
	jtsTg+ZXiO2MRSzo36Dm0pCWvJSg0XnI=
X-Gm-Gg: Acq92OH9lXFx6OJN2rkFzfqggRdXBUQcDirH4ti2LYIX2NsrJ98Q0LGmDIhsMozfEvw
	DIvwZyp/wuoO1j5T8tGP7roSTwQ2jV5morVqpG9QOxsjLge3vhD1Fs2P59pxVYNPgnfpMi/hwrf
	chyLczt4c9SbWHpaqgYTZ2nN2+Pwu9eFTCsL+oRf8/5SX62jZTKYABAm9LxmzF52CEDjDDjwAwE
	wzjWGnqVPGuuGYN7Wc+HA4KoXgpgioF+LDYXEwauzq4BQVLRG2/JWiDy4ID33BKWZezxgrcBVGy
	fIMNHElGwWC2RUvWUfO21RIpjon2GE1Jmn5XXMyjyzWWnOLvUokIFjdrUE1M1WoxaOsAuvfsj40
	JzMHFRQ8KimKEIiJa
X-Received: by 2002:a05:6a00:94c3:b0:842:614e:cc97 with SMTP id
 d2e1a72fcca58-8434d07afcemr4940308b3a.23.1781295823460; Fri, 12 Jun 2026
 13:23:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <287e6b7dd877836e08b9bcb6727f547fe80f6459.1780855297.git.lucien.xin@gmail.com>
 <20260611081948.137325-1-pabeni@redhat.com>
In-Reply-To: <20260611081948.137325-1-pabeni@redhat.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 12 Jun 2026 16:23:31 -0400
X-Gm-Features: AVVi8CezbNK4UF3r3lp5uUhw4KnTH33E-BGYuPbz2M3O-qwCLN8CyhZyYdcGzpo
Message-ID: <CADvbK_dAvqBC1j-f4Ft_HkLzVOzP-z9cwVR2B36zbxjSB44atg@mail.gmail.com>
Subject: Re: [PATCH net-next v13 12/15] quic: add crypto packet encryption and decryption
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, quic@lists.linux.dev, davem@davemloft.net, 
	kuba@kernel.org, edumazet@google.com, horms@kernel.org, metze@samba.org, 
	mbuhl@openbsd.org, tfanelli@redhat.com, hepengtao@xiaomi.com, 
	dreibh@simula.no, linux-cifs@vger.kernel.org, smfrench@gmail.com, 
	linkinjeon@kernel.org, tom@talpey.com, kernel-tls-handshake@lists.linux.dev, 
	chuck.lever@oracle.com, jlayton@kernel.org, steved@redhat.com, hare@suse.de, 
	aahringo@redhat.com, dhowells@redhat.com, matttbe@kernel.org, 
	mail@johnericson.me, xiyou.wangcong@gmail.com, alibuda@linux.alibaba.com, 
	jbaron@akamai.com, illiliti@protonmail.com, sd@queasysnail.net, 
	marcelo.leitner@gmail.com, daniel@haxx.se, andrew.gospodarek@broadcom.com, 
	mef@scarletmail.rutgers.edu, paul@jakma.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:quic@lists.linux.dev,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:horms@kernel.org,m:metze@samba.org,m:mbuhl@openbsd.org,m:tfanelli@redhat.com,m:hepengtao@xiaomi.com,m:dreibh@simula.no,m:linux-cifs@vger.kernel.org,m:smfrench@gmail.com,m:linkinjeon@kernel.org,m:tom@talpey.com,m:kernel-tls-handshake@lists.linux.dev,m:chuck.lever@oracle.com,m:jlayton@kernel.org,m:steved@redhat.com,m:hare@suse.de,m:aahringo@redhat.com,m:dhowells@redhat.com,m:matttbe@kernel.org,m:mail@johnericson.me,m:xiyou.wangcong@gmail.com,m:alibuda@linux.alibaba.com,m:jbaron@akamai.com,m:illiliti@protonmail.com,m:sd@queasysnail.net,m:marcelo.leitner@gmail.com,m:daniel@haxx.se,m:andrew.gospodarek@broadcom.com,m:mef@scarletmail.rutgers.edu,m:paul@jakma.org,m:xiyouwangcong@gmail.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-298789-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,davemloft.net,kernel.org,google.com,samba.org,openbsd.org,redhat.com,xiaomi.com,simula.no,gmail.com,talpey.com,oracle.com,suse.de,johnericson.me,linux.alibaba.com,akamai.com,protonmail.com,queasysnail.net,haxx.se,broadcom.com,scarletmail.rutgers.edu,jakma.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8BF6367C457

On Thu, Jun 11, 2026 at 4:20=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> From: AI Reviewer <ai@example.com>
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/
> ---
> quic: add crypto packet encryption and decryption
>
> This patch adds AEAD-based packet encryption/decryption helpers, QUIC
> header protection, and Retry/address-validation token generation and
> verification primitives.
>
> > diff --git a/net/quic/crypto.c b/net/quic/crypto.c
> > index c68a0b570c72..77e633096c2a 100644
> > --- a/net/quic/crypto.c
> > +++ b/net/quic/crypto.c
>
> [ ... ]
>
> > +/* Retry Packet Integrity. */
> > +int quic_crypto_get_retry_tag(struct quic_crypto *crypto, struct sk_bu=
ff *skb,
> > +                           struct quic_conn_id *odcid, u32 version, u8=
 *tag)
> > +{
> > +     /* Reuse RX AEAD (phase 1) in Initial crypto. */
> > +     struct crypto_aead *tfm =3D crypto->rx_tfm[1];
> > +     u8 *pseudo_retry, *p, *iv, *key;
> > +     DECLARE_CRYPTO_WAIT(wait);
> > +     struct aead_request *req;
> > +     struct scatterlist *sg;
> > +     u32 plen;
> > +     int err;
> > +
> > +     if (skb->len < QUIC_TAG_LEN)
> > +             return -EINVAL;
>
> [Low]
> The guard rejects skb->len < QUIC_TAG_LEN, but a later comment in the
> same function says:
>
> > +     /* The caller must ensure skb->len > QUIC_TAG_LEN. */
> > +     plen =3D 1 + odcid->len + skb->len - QUIC_TAG_LEN;
>
> Should the check be <=3D QUIC_TAG_LEN, or should the comment say >=3D to
> match the strict-less-than test?
>
> In the boundary case where skb->len =3D=3D QUIC_TAG_LEN, plen becomes
> 1 + odcid->len, and quic_put_data(p, skb->data, skb->len - QUIC_TAG_LEN)
> copies zero bytes, so the integrity tag would be computed over a
> pseudo-packet containing only the ODCID length and ODCID with no actual
> Retry header bytes.  Is that intended?
>
The callers will make sure skb->len > QUIC_TAG_LEN, and the check
(skb->len < QUIC_TAG_LEN) was added to make the last AI happy.

I will change (skb->len <=3D QUIC_TAG_LEN) to match the comment.


> [ ... ]
>
> > +/* Derives a key and IV using HKDF, configures the AEAD transform and =
performs
> > + * AEAD encryption/decryption for the provided token.
> > + */
> > +static int quic_crypto_token_protect(struct quic_crypto *crypto, u8 *t=
oken,
> > +                                  u32 len, u32 adlen, bool enc)
> > +{
> > +     u8 key[TLS_CIPHER_AES_GCM_128_KEY_SIZE], iv[QUIC_IV_LEN], *tiv;
> > +     /* Reuse TX AEAD (phase 1) in Initial crypto. */
> > +     struct crypto_aead *tfm =3D crypto->tx_tfm[1];
> > +     u32 extra =3D enc ? QUIC_TAG_LEN : 0;
> > +     struct quic_data srt =3D {}, k, i;
> > +     DECLARE_CRYPTO_WAIT(wait);
> > +     struct aead_request *req;
> > +     struct scatterlist *sg;
> > +     void *ctx =3D NULL;
> > +     int err;
> > +
> > +     quic_data(&srt, quic_random_data, QUIC_RANDOM_DATA_LEN);
> > +     quic_data(&k, key, TLS_CIPHER_AES_GCM_128_KEY_SIZE);
> > +     quic_data(&i, iv, QUIC_IV_LEN);
> > +     err =3D quic_crypto_keys_derive(crypto->secret_tfm, &srt, &k, &i,=
 NULL,
> > +                                   QUIC_VERSION_V1);
>
> [Critical]
> Can this lead to AES-GCM nonce reuse across all generated tokens?
>
> quic_random_data is a module-global buffer initialized once in
> quic_crypto_init() via get_random_bytes() and never refreshed:
>
>     static u8 quic_random_data[QUIC_RANDOM_DATA_LEN] __read_mostly;
>
> quic_crypto_keys_derive() runs HKDF-Expand-Label over that constant
> secret with constant labels "quic key" and "quic iv", so both the
> derived key and the derived IV are deterministic and identical on every
> invocation of quic_crypto_token_protect().
>
> > +     if (err)
> > +             goto out;
> > +     err =3D crypto_aead_setauthsize(tfm, QUIC_TAG_LEN);
> > +     if (err)
> > +             goto out;
> > +     err =3D crypto_aead_setkey(tfm, key, TLS_CIPHER_AES_GCM_128_KEY_S=
IZE);
> > +     if (err)
> > +             goto out;
> > +     ctx =3D quic_crypto_aead_mem_alloc(tfm, 0, &tiv, &req, &sg, 1);
> > +     if (!ctx) {
> > +             err =3D -ENOMEM;
> > +             goto out;
> > +     }
> > +     memcpy(tiv, iv, QUIC_IV_LEN);
> > +
> > +     sg_init_one(sg, token, len);
> > +     aead_request_set_tfm(req, tfm);
> > +     aead_request_set_ad(req, adlen);
> > +     aead_request_set_crypt(req, sg, sg, len - adlen - extra, tiv);
>
> Every call ends up using the same (K, N) pair under AES-GCM, with no
> per-token random prefix and no packet-number XOR like
> quic_crypto_payload_protect() does via cb->number.
>
> NIST SP 800-38D forbids reuse of (K, N) under GCM; from two valid
> ciphertexts an attacker can recover the GHASH authentication subkey H
> and forge tokens for arbitrary client addresses, which would defeat
> the address validation in quic_crypto_verify_token() and the
> anti-amplification protections in RFC 9000 section 8.
>
> Could a unique per-token nonce be derived (for example from a random
> prefix stored in the token itself), or a nonce-misuse-resistant AEAD
> be used here instead?
>

I currently don't have a better solution for this. we can't have it in the
socket, as even after the socket closes, this quic_random_data is still
needed to validate tokens.

Thanks.

> > +     aead_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
> > +                               crypto_req_done, &wait);
> > +     err =3D enc ? crypto_aead_encrypt(req) : crypto_aead_decrypt(req)=
;
> > +     if (err =3D=3D -EINPROGRESS || err =3D=3D -EBUSY)
> > +             err =3D crypto_wait_req(err, &wait);
> > +
> > +out:
> > +     memzero_explicit(key, sizeof(key));
> > +     memzero_explicit(iv, sizeof(iv));
> > +     kfree_sensitive(ctx);
> > +     return err;
> > +}
>
> [ ... ]
> --
> This is an AI-generated review.
>


Return-Path: <netdev+bounces-264071-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPZ1AXOzqGlgwgAAu9opvQ
	(envelope-from <netdev+bounces-264071-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 23:34:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFC5208A76
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 23:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78DE6300DDFE
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 22:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58221396575;
	Wed,  4 Mar 2026 22:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hn5q+uLu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D191D39A045
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 22:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772663534; cv=pass; b=OzC0k2+GWqDmxurnbc44+7ihLE/N1qP1syMsM3PBen4AU6W5OxGxFwhWQdeETNR0p7fEIxO7IjkqMp6GMZaZOXffsKnX/1DF0ZvnnEHp0bXauVnvlUCrUvltT0HdxbHxAhqbIK+HHVPbBOYWmAx3tp0ibEP/P1SfuSaO4F53sRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772663534; c=relaxed/simple;
	bh=KXu//3EBPLrBvO/MghuctSsCjd474Oji/fve+ps6wFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j2KfqI+Go50OZPWIHsbRqldC7An0bC5cBlAP2fGbTxp8jenfli4I566tL3PFuQKMrMnvATiurfjFDU9AL0/uNfS4cJNWc5wIgEuRIZEZy0duNLduq1UbTFisjvMBXoIabu4gub0X6q0ANIpmt75+JitqLOXjvkmBI6CY3qNm4KY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hn5q+uLu; arc=pass smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-94dd2d71231so2202775241.0
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 14:32:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772663531; cv=none;
        d=google.com; s=arc-20240605;
        b=PlGJ2YJo8J2Bk6zmFZZrQzOJWHNp+FMD0LxegQh5AAMnjACiYKYvU2O47TrCyGL2jJ
         pWFqWNCr4Mq+cS7j6/CHjWzkVcterZY8YSvKGK/TSkrGNp13hkAbPzRKt4TUkzuL+Daa
         4RSHuWCDA7mai7JUqeKgDk1KIB1QCgVFJcca7n2CDc33TchOhx6i14EUiKuTCI7mLNZH
         T2ITjYxbUFu6wryVrPWUmjgDfDk4ozCiEcUSZ0EO4Mmx46dwXDJJuF6szcTpiXjOIzFy
         tzvGhILeBRo9FTaBZYKuzCoqp7KJKiOzxaMTNO3Nb/OLJm8m0AHUygiBaK4vyEmneyRv
         ywUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z/QRphmRzy8FO2fkKgVz78bs8tUVjsFCxQ1wuKvg3pk=;
        fh=kU8c6s3ZR95BMdg43Yz47kXVwqPGqLQLyhFnfH3Hg/U=;
        b=TAiMyZv9OGyxPAtIsshEkOKdgJ74vtS1S0XEtKbwwt82Dmd9RZLf7U0hY3qmCD9kbv
         fgJJ4M1ReIcY3BWgbRtVZINPLMUZ76yBfuE22DZwIWJneNUqm7nObQg/Q3dgeAav7r5J
         iVeXV2s3w1HRuP54FISSeqCqm6uVi/RZi0Jxi+5yccMxPqYvvo++NKrxYkPJhDotgEA3
         ZhCmuo5lcCCPtpfqJ6T1Lyt9jYU08Dy+e9pE8BGgTfwfndvw0dnFpuMtyAK8pEhzTXmu
         iFupQz5Uu8Ks7h9PCP1/GedYFbfx0DZeVxA33yG/bL5obvm2V59UONCPpcP5gB53LjRj
         jEPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772663531; x=1773268331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z/QRphmRzy8FO2fkKgVz78bs8tUVjsFCxQ1wuKvg3pk=;
        b=hn5q+uLuYQJFI83/xK/Vuu128PMbAr3QfZZ9RqYskdHx245x8xq5+iWEkmBKjXVRTJ
         WMgu7YsrRxEoaT04SPsiQAO4BNr4rw2qasTMDcuDvlB2lrrio59DXa9Zy42U8Qyo+sEg
         9kybkTGGzEzY8rCnsToLHxesJ0/c/bY32aD0UTHti1nMghWOQX9UdqFsNrAoz+5G5kgd
         5JLoXthawmt+qjd3YuC2927ikvctTSg03JTCLemU/R/6MBn2fcw8C/Ywy3q+kkZ4PCSt
         tGLw6mtMxUMk87xaDhplsiyKya22DsSzpQOkvmtujdgqXWrHWaP83wzpJxjJxlwgXpcl
         KPLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772663531; x=1773268331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z/QRphmRzy8FO2fkKgVz78bs8tUVjsFCxQ1wuKvg3pk=;
        b=QhQ4QfI6vlsBpO8OJUESdf3P3eCoHpsR2bQk7SfKvF5vYT/+kbyAod4XzISyYOCRWb
         FlURzM06++I7HNs+H9asHbbx3tskObaID6oK/I0wskpKBZJwwP8knqOt90f6Llwp1ZjZ
         WV3/t8btKbD9R1LXoJU1839pRC+CTdqG6xdA6IjpdgyobmewxWNuTVv6utWMJzJLKRdV
         DBoTFEwqa2kFiNMt3RMXJKfXehnYtZk35TZc+ap3sPLyM1ze7EXJe2kG8KApk5zu2OhV
         ca04eZb0xqYikLe0YKkztWhMctwGrg4LmXdcK/vVhEc9vnlvhvdDOllP1euJSSF9YssV
         CU+g==
X-Forwarded-Encrypted: i=1; AJvYcCWyp5Qjr+0lvYTUiRbEU+lezzR4/QZcFS0frN7premjhad0PcXb76douHDF+gP2i9Ty5Kdi8Rk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz00eg4fmpaS5b/AXtAwRZO3b3jLis2gMMnzsQ4CJWRU8QCEHhA
	8ZplxHAQw8LdcAn91cduMZdy/fMm/H9z+A2pSI/2kx0pnbkUquCH4nfC6Y3sNvaX/YOEBZ+V8iF
	eQUi4WElWDNGgVLtSbsOcyQ1TIVuH0TlLdU/wSvR0GQ==
X-Gm-Gg: ATEYQzzuFbGv/rHFp7eOaB4rhCp+L0PqUqKZY5kkFTUpiuoogi47gImfD647GzOI9P6
	wmuDzalmCwjd3rNzUKfokj/pynshUNMzxOecoqgnRGz5TcrQ5D/vy/lHkbeekMRuYm0T0SCzZq3
	AsP3MVSFv6fZ1VyzVLTP6REqYWjME0P1+DeyCQSkOj/EMbOryj4AR0qo5R5gWjYcUdD9gtzzRGF
	7CnYbycbhK4DhnyYjMnzVnfqGi4JA9chdtAA4pys4nqI3PG9r7gUaSloheDXjYiMmS6etwO6jyl
	NEX25GSvCUBEnt36VgNfXSzVMZAX+2ft8yZ24MJsk9juYGoa/CJvdzgLTdFFNDPwOLOTGrPFZzQ
	dZD6ZUg==
X-Received: by 2002:a05:6102:b0d:b0:5f8:e2c7:a3f2 with SMTP id
 ada2fe7eead31-5ffaa6f6c3bmr1576946137.0.1772663530592; Wed, 04 Mar 2026
 14:32:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3c6ae7299c2fff0fa689d4dcd43ef916e5697d65.1771986861.git.lucien.xin@gmail.com>
 <20260303083255.35354-1-pabeni@redhat.com>
In-Reply-To: <20260303083255.35354-1-pabeni@redhat.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 4 Mar 2026 17:31:57 -0500
X-Gm-Features: AaiRm51Y186obU2AYuGIwk5fISUHhxMUkh7jtjQG4bgQBZwaKmERG0jYjFiCfpA
Message-ID: <CADvbK_fHhrCh-5zPDY1sh16TEKhJTWhZcUS4-pw=49krocV3SA@mail.gmail.com>
Subject: Re: [net-next,v10,12/15] quic: add crypto packet encryption and decryption
To: Paolo Abeni <pabeni@redhat.com>
Cc: hepengtao@xiaomi.com, kuba@kernel.org, jlayton@kernel.org, metze@samba.org, 
	davem@davemloft.net, kernel-tls-handshake@lists.linux.dev, horms@kernel.org, 
	hare@suse.de, aahringo@redhat.com, tfanelli@redhat.com, mail@johnericson.me, 
	andrew.gospodarek@broadcom.com, linkinjeon@kernel.org, dhowells@redhat.com, 
	matttbe@kernel.org, xiyou.wangcong@gmail.com, dreibh@simula.no, 
	jbaron@akamai.com, quic@lists.linux.dev, pc@manguebit.com, 
	marc@fiuczynski.com, edumazet@google.com, alibuda@linux.alibaba.com, 
	steved@redhat.com, illiliti@protonmail.com, tom@talpey.com, 
	marcelo.leitner@gmail.com, sd@queasysnail.net, linux-cifs@vger.kernel.org, 
	netdev@vger.kernel.org, mbuhl@openbsd.org, smfrench@gmail.com, 
	chuck.lever@oracle.com, daniel@haxx.se
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 2CFC5208A76
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264071-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[35];
	FREEMAIL_CC(0.00)[xiaomi.com,kernel.org,samba.org,davemloft.net,lists.linux.dev,suse.de,redhat.com,johnericson.me,broadcom.com,gmail.com,simula.no,akamai.com,manguebit.com,fiuczynski.com,google.com,linux.alibaba.com,protonmail.com,talpey.com,queasysnail.net,vger.kernel.org,openbsd.org,oracle.com,haxx.se];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linux.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 3, 2026 at 3:33=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-loca=
l.html
> ---
> quic: add crypto packet encryption and decryption
>
> This patch adds core support for packet-level encryption and decryption
> using AEAD, including both payload protection and QUIC header protection.
> It introduces helpers to encrypt and decrypt packets for secure QUIC
> packet exchange and address validation.
>
> > diff --git a/net/quic/crypto.c b/net/quic/crypto.c
> > index a9de418e604e..a84fd8d7bf93 100644
> > --- a/net/quic/crypto.c
> > +++ b/net/quic/crypto.c
>
> [ ... ]
>
> > @@ -231,6 +562,137 @@ static struct quic_cipher ciphers[QUIC_CIPHER_MAX=
 + 1 - QUIC_CIPHER_MIN] =3D {
>
> [ ... ]
>
> > +/* Encrypts a QUIC packet before transmission.  This function performs=
 AEAD encryption of
> > + * the packet payload and applies header protection. It handles key ph=
ase tracking and key
> > + * update timing.
> > + *
> > + * Return: 0 on success, or a negative error code.
> > + */
> > +int quic_crypto_encrypt(struct quic_crypto *crypto, struct sk_buff *sk=
b)
> > +{
> > +     u8 *iv, cha, ccm, phase =3D crypto->key_phase;
> > +     struct quic_skb_cb *cb =3D QUIC_SKB_CB(skb);
> > +     int err;
> > +
> > +     cb->key_phase =3D phase;
> > +     iv =3D crypto->tx_iv[phase];
> > +     /* Packet payload is already encrypted (e.g., resumed from async)=
, proceed to header
> > +      * protection only.
> > +      */
> > +     if (cb->resume)
> > +             goto out;
> > +
> > +     /* If a key update is pending and this is the first packet using =
the new key, save the
> > +      * current time. Later used to clear old keys after some time has=
 passed (see
> > +      * quic_crypto_decrypt()).
> > +      */
> > +     if (crypto->key_pending && !crypto->key_update_send_time)
> > +             crypto->key_update_send_time =3D quic_ktime_get_us();
> > +
> > +     ccm =3D quic_crypto_is_cipher_ccm(crypto);
> > +     err =3D quic_crypto_payload_encrypt(crypto->tx_tfm[phase], skb, i=
v, ccm);
> > +     if (err)
> > +             return err;
> > +out:
> > +     cha =3D quic_crypto_is_cipher_chacha(crypto);
> > +     return quic_crypto_header_encrypt(crypto->tx_hp_tfm, skb, cha);
> > +}
>
> This function calls quic_crypto_payload_encrypt(). Looking at that
> function:
>
> > +/* AEAD Usage. */
> > +static int quic_crypto_payload_encrypt(struct crypto_aead *tfm, struct=
 sk_buff *skb,
> > +                                    u8 *tx_iv, bool ccm)
> > +{
> > +     struct quic_skb_cb *cb =3D QUIC_SKB_CB(skb);
> > +     u8 *iv, i, nonce[QUIC_IV_LEN];
> > +     struct aead_request *req;
> > +     struct sk_buff *trailer;
> > +     struct scatterlist *sg;
> > +     struct quichdr *hdr;
> > +     u32 nsg, hlen, len;
> > +     void *ctx;
> > +     __be64 n;
> > +     int err;
> > +
> > +     len =3D skb->len;
> > +     err =3D skb_cow_data(skb, QUIC_TAG_LEN, &trailer);
> > +     if (err < 0)
> > +             return err;
> > +     nsg =3D (u32)err;
> > +     pskb_put(skb, trailer, QUIC_TAG_LEN);
> > +     hdr =3D quic_hdr(skb);
> > +     hdr->key =3D cb->key_phase;
> > +
> > +     ctx =3D quic_crypto_aead_mem_alloc(tfm, 0, &iv, &req, &sg, nsg);
> > +     if (!ctx)
> > +             return -ENOMEM;
>
> If the kzalloc(GFP_ATOMIC) inside quic_crypto_aead_mem_alloc() fails,
> this returns -ENOMEM without rolling back the SKB modifications. The
> SKB is now permanently enlarged by QUIC_TAG_LEN (16 bytes) with a
> modified hdr->key.
>
> Compare with quic_crypto_payload_decrypt():
>
> > +static int quic_crypto_payload_decrypt(struct crypto_aead *tfm, struct=
 sk_buff *skb,
> > +                                    u8 *rx_iv, bool ccm)
> > +{
> > +     struct quic_skb_cb *cb =3D QUIC_SKB_CB(skb);
> > +     u8 *iv, i, nonce[QUIC_IV_LEN];
> > +     struct aead_request *req;
> > +     int nsg, hlen, len, err;
> > +     struct scatterlist *sg;
> > +     void *ctx;
> > +     __be64 n;
> > +
> > +     len =3D cb->length + cb->number_offset;
> > +     hlen =3D cb->number_offset + cb->number_len;
> > +     if (len - hlen < QUIC_TAG_LEN)
> > +             return -EINVAL;
> > +     nsg =3D 1; /* skb is already linearized in quic_packet_rcv(). */
> > +     ctx =3D quic_crypto_aead_mem_alloc(tfm, 0, &iv, &req, &sg, nsg);
> > +     if (!ctx)
> > +             return -ENOMEM;
> > +
> > +     sg_init_table(sg, nsg);
> > +     err =3D skb_to_sgvec(skb, sg, 0, len);
>
> In the decrypt path, quic_crypto_aead_mem_alloc() is called before any
> SKB modifications. Should quic_crypto_payload_encrypt() do the same to
> avoid leaving the SKB in a modified state if allocation fails?
>
This is not true.

- firstly, on RX or Decrypt path, skb_cow_data() is called in
quic_crypto_header_decrypt(), which is called before
quic_crypto_payload_decrypt() in quic_crypto_decrypt(), so
skb_cow_data() is called before mem_alloc for both places.

- secondly, even if the mem_alloc is failed, the skb will be dropped,
no issue could be caused.

> [ ... ]
>
> > +     /* Similar logic to quic_crypto_payload_encrypt(). */
> > +     memcpy(nonce, rx_iv, QUIC_IV_LEN);
> > +     n =3D cpu_to_be64(cb->number);
> > +     for (i =3D 0; i < sizeof(n); i++)
> > +             nonce[QUIC_IV_LEN - sizeof(n) + i] ^=3D ((u8 *)&n)[i];
>
> This isn't a bug, but there's duplicated logic between
> quic_crypto_payload_encrypt() and quic_crypto_payload_decrypt(). The
> AEAD nonce construction sequence (memcpy nonce from IV, XOR with be64
> packet number, set CCM byte) appears in both functions.
>
> In quic_crypto_payload_encrypt():
>
> > +     hlen =3D cb->number_offset + cb->number_len;
> > +     memcpy(nonce, tx_iv, QUIC_IV_LEN);
> > +     n =3D cpu_to_be64(cb->number);
> > +     for (i =3D 0; i < sizeof(n); i++)
> > +             nonce[QUIC_IV_LEN - sizeof(n) + i] ^=3D ((u8 *)&n)[i];
> > +
> > +     /* For CCM based ciphers, first byte of IV is a constant. */
> > +     iv[0] =3D TLS_AES_CCM_IV_B0_BYTE;
> > +     memcpy(&iv[ccm], nonce, QUIC_IV_LEN);
>
> And in quic_crypto_payload_decrypt():
>
> > +     /* Similar logic to quic_crypto_payload_encrypt(). */
> > +     memcpy(nonce, rx_iv, QUIC_IV_LEN);
> > +     n =3D cpu_to_be64(cb->number);
> > +     for (i =3D 0; i < sizeof(n); i++)
> > +             nonce[QUIC_IV_LEN - sizeof(n) + i] ^=3D ((u8 *)&n)[i];
> > +
> > +     iv[0] =3D TLS_AES_CCM_IV_B0_BYTE;
> > +     memcpy(&iv[ccm], nonce, QUIC_IV_LEN);
>
> The AEAD request teardown pattern (EINPROGRESS check, kfree_sensitive,
> memzero_explicit) is also duplicated. Would a shared static helper for
> nonce construction reduce the risk of the two copies diverging during
> maintenance?
>
I will see what I can do to dedup a bit for this.

Thanks.


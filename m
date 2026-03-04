Return-Path: <netdev+bounces-264057-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIqlBf+qqGmfwQAAu9opvQ
	(envelope-from <netdev+bounces-264057-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 22:58:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 078D72083B3
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 22:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D921730131E4
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 21:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DF9388395;
	Wed,  4 Mar 2026 21:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bknOqe/Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33541381B04
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 21:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772661497; cv=pass; b=cDB9td3lxQSX3qHCkMSH5AIFXxm4RlrxU7A+CEeQKuNGBvv3p4kPaaHzeXt1/P/2OJjCqoUJAdJ4ubcCxzBRvh/3ng8N1NmQDTJlmkKrWJltyhUneeaO/D00AbncYCY1Qdz7ueqAaaHa3Rkg2iwDvHFu0MDMRlSb9X7U/rixaTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772661497; c=relaxed/simple;
	bh=uCVtAulQYUleILEJ6PEjL9aQkaLSkuY4rEkEB5Iccc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JDPqtODr1AN11IfuSOwj3HdOgUyDuX0IYMc7wlTewFfd7KqDJLgXBasYCUf5UgZejp7URILcV4WIBHaUT6VIXtrcA4O5b87YX61qfKNlCO+dhsJSUs664dGwTXSsdTREE/vkWTM7fM+8RBSt59grxUyzGBBcby1k/CqWbcTe02I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bknOqe/Q; arc=pass smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-5ff9f2e1fbaso617334137.1
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 13:58:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772661495; cv=none;
        d=google.com; s=arc-20240605;
        b=EJ3d2uM1NMTn/iJiC4ruDYo6wZFXjk8AzEqRfzQltzVX6mqTzV6NE4YjVZHTjl5VHq
         gD8RAHLpf8cB5YxjW8s2IPxiTi/nbFy4pnWAf8VHs+PzSRiOfxdtzVe81iLt98WzD4XE
         dYpP3J5ET1dlSnRnyMU7ctRy9QPUKO0frhQLCEVpTougJozwCgXC/xxzdnXdGTvkV8vG
         jYS6gWpvrMAmcfDmbDoxo2MqyP9YoOrYk5uJEpCImCtY/vRMo2R97b4glP7pYqkhSQVa
         bh46q03dOcixpnchqFva2kC9UVkKxD2s2lHL9CqKtT3DeShK4xfOa6F55ty9+pnCCB03
         +y6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QKWCkXz0n+kEHmLabX5g1II5xKBH3YQOX4ZTihzPz58=;
        fh=s1PFrlEST/sTyfrydC/duPUZQEvUdc5VWUiEXNYSjTs=;
        b=jDv3wPAOtSrj3SPS6AoFsVGAyMux2laNXXDsdfuDrliNd2P5prqA+UAO82iLUGFYAR
         8XpohEiq4+KLGVKSi0dXy5G5n9vJPQe3OIxqbdZkVG8r3cbjE/WoErMJnCJWkODIN4+f
         bg4cX0gfLYIV7JPPhTT+P/014yh811MuRignNtDfIV9xsMKp/k+U8mAlyiJyZ3khftUy
         BCmsuOIBKz7yJCZXGuwFr9cTJbcFQH3neUXDFYsMDfmnVlARInhXTu2txV6vsHuWWCNG
         U7GY4Uj4QgKR8JyST6BxhKw8h60F+QbuQlI+9D7hbxF+ujtji3VaOiEPqdrc6f232f7i
         eOQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772661495; x=1773266295; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QKWCkXz0n+kEHmLabX5g1II5xKBH3YQOX4ZTihzPz58=;
        b=bknOqe/Q3ViNm968LpcDQ54rkED/FEk09l6mAA2bY3oD6fVK4iZdJ5rrCO/SHG8Nrj
         ekleXZFZt8rQD4oI0eODaTQjzdy3BWd8DjRGFuOQLp91eciTENXOmLpew6eYHNWMeLb2
         P6H8U3gEl63u95Bv7u5AL5AvAG8NeqcthHFEfg/TFEjtGxG905POupCzTXJXMp+BxEgf
         GoNSulZgl5glNxT3I7aM6GMn5eryVATt+ZQRZL6PQGBrln7aGs1zRLBktrBEEEpVeOpQ
         MsUYGX0ZNfdrNPe8b/9yE50moXHCtEdSB03Xnmy6k+RW+GNpoPQK7zlQh8IyA/Hr/YLc
         oCIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772661495; x=1773266295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QKWCkXz0n+kEHmLabX5g1II5xKBH3YQOX4ZTihzPz58=;
        b=L30u0C+B0OTjK7PdzGlNNRxyD57KB1aHawojdYtKjKka6TbUZwS1DgOocUnv4DKNUb
         eVEXjos2NRWdRd/Je84e1DpnTPc3qZMvEBW/xVCWJyHmVbdg4brHynm+1d5lkSu7L9wS
         sPbPpTCeXOmhHXHNAb4LUrIqnqjohPKgPlphXoKTykOwlGr3YVwd+fN014SmFY3ouRkF
         hfYQ5rbBGSnCeDLvwxANxy7JWw+0fTeCCThAlW/6DgvbTO1I6A3m/o2UZLWlSJ0dgcey
         sBakb2Nz5j8fFojmOxcFrWdxaaxjLRDAupfycPCSwPUMOMOR9C7LfYOKPmL9VUxExi8f
         vQEA==
X-Forwarded-Encrypted: i=1; AJvYcCXFY+yj+3vwimeXtcVKX0GVQuROKkFd3ak9mU1//wng+GaM9tD3BZgv4ATlw39vTv6r/Z+M0Bc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp/p+ZOxLgGLAZiIvojHmvWciHu/ptXAsgM9nFTkcs9NQT01YO
	ZXRSircU0BNv2N/Ysx6sPef2WHYR7OYKJffFDDxa2EcHJ5rgdkBLSaPfCxY/djYTvqyRlcYs/yS
	5UNk74M8wJZIgEG1Ffa94M8/g5vFqd4o=
X-Gm-Gg: ATEYQzzC+TqU5MmV5JKJiIusfkM4pmhMCcGFLTYTuA6ljcq0BHaTSu5gMw023WxeUAV
	v4gwv9T1jNZO1KYvuqc4I2SbSurYRCwcU7mXEnI/OPMZMBYGYwc9sr9XM/CYNzAj9BjIGO4f+8k
	eVCp+gZQ/KGcYTbcQS5xkcgnHvIv3i1R+sgGhVNSh7vNS7brmj8fH9CJWNvMuz3PbCpVlnNQkOf
	RCssMugXFXffuU1/Ww4Y2g61eDXwPx6sTvgMHdD6PmHX7hm8bPd1DXxoHsHNyrUgksgezirhpLi
	QU0edHKq37g7DlDM8SiQD6ikKeg3GopfOZaQ4K5wwhvlzTA6+/zyyr7kY5R701WYe45pNoMTS3M
	x77TUng7HFiGgyUZgDoyOhS07z0gnnWpZAlOow6oc
X-Received: by 2002:a05:6102:3f43:b0:5fd:fc84:4b0 with SMTP id
 ada2fe7eead31-5ffaaffd485mr1677319137.35.1772661495041; Wed, 04 Mar 2026
 13:58:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <323138c6deed2652a09aa38dfbe322642b6ad150.1771986861.git.lucien.xin@gmail.com>
 <20260303083233.34650-1-pabeni@redhat.com>
In-Reply-To: <20260303083233.34650-1-pabeni@redhat.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 4 Mar 2026 16:58:01 -0500
X-Gm-Features: AaiRm50J6ffZdZLFUmhSXQoVur0S3uDqiz0HfuAqGi8QNmmBNRW9dW8AvLSff9M
Message-ID: <CADvbK_cWP-S1VdsfZJCc_iTxaeVnGTbrXrNsVdWTgYjdqLjwaA@mail.gmail.com>
Subject: Re: [net-next,v10,11/15] quic: add crypto key derivation and installation
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
X-Rspamd-Queue-Id: 078D72083B3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264057-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.dev:url]
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
> quic: add crypto key derivation and installation
>
> This patch introduces 'quic_crypto', a component responsible for QUIC
> encryption key derivation and installation across the various key
> levels: Initial, Handshake, 0-RTT (Early), and 1-RTT (Application).
> It provides helpers to derive and install initial secrets, set traffic
> secrets and install the corresponding keys, and perform key updates to
> enable forward secrecy.
>
> > diff --git a/net/quic/Makefile b/net/quic/Makefile
> > index 9d8e18297911..58bb18f7926d 100644
> > --- a/net/quic/Makefile
> > +++ b/net/quic/Makefile
> > @@ -6,4 +6,4 @@
> >  obj-$(CONFIG_IP_QUIC) +=3D quic.o
> >
> >  quic-y :=3D common.o family.o protocol.o socket.o stream.o connid.o pa=
th.o \
> > -       cong.o pnspace.o
> > +       cong.o pnspace.o crypto.o
> > diff --git a/net/quic/crypto.c b/net/quic/crypto.c
> > new file mode 100644
> > index 000000000000..a9de418e604e
> > --- /dev/null
> > +++ b/net/quic/crypto.c
>
> [ ... ]
>
> > +/* Initial Secrets. */
> > +int quic_crypto_initial_keys_install(struct quic_crypto *crypto, struc=
t quic_conn_id *conn_id,
> > +                                  u32 version, bool is_serv)
> > +{
> > +     u8 secret[TLS_CIPHER_AES_GCM_128_SECRET_SIZE];
> > +     struct quic_data salt, s, k, l, dcid, z =3D {};
> > +     struct quic_crypto_secret srt =3D {};
> > +     char *tl, *rl, *sal;
> > +     int err;
> > +
> > +     if (is_serv) {
> > +             rl =3D "client in";
> > +             tl =3D "server in";
> > +     } else {
> > +             tl =3D "client in";
> > +             rl =3D "server in";
> > +     }
> > +     sal =3D QUIC_INITIAL_SALT_V1;
> > +     if (version =3D=3D QUIC_VERSION_V2)
> > +             sal =3D QUIC_INITIAL_SALT_V2;
> > +     quic_data(&salt, sal, QUIC_INITIAL_SALT_LEN);
> > +     quic_data(&dcid, conn_id->data, conn_id->len);
> > +     quic_data(&s, secret, TLS_CIPHER_AES_GCM_128_SECRET_SIZE);
> > +     err =3D quic_crypto_hkdf_extract(crypto->secret_tfm, &salt, &dcid=
, &s);
>
> Is crypto->secret_tfm guaranteed to be initialized at this point?
>
> Looking at the function flow, this line uses crypto->secret_tfm before
> quic_crypto_set_secret() below gets a chance to initialize the cipher:
>
> quic_crypto_initial_keys_install() {
>         err =3D quic_crypto_hkdf_extract(crypto->secret_tfm, ...); /* lin=
e 490 */
>         ...
>         err =3D quic_crypto_set_secret(crypto, &srt, version, 0);  /* lin=
e 497 */
> }
>
> If quic_crypto_set_cipher() hasn't been called on this struct quic_crypto
> yet, crypto->secret_tfm is NULL.
>
> This contrasts with quic_crypto_set_secret(), which has lazy initializati=
on:
>
> quic_crypto_set_secret() {
>         if (!crypto->cipher) {
>                 err =3D quic_crypto_set_cipher(crypto, srt->type, flag);
>                 if (err)
>                         return err;
>         }
>         ...
> }
>
> Without this initialization, quic_crypto_hkdf_extract() flows through
> hkdf_extract() -> crypto_shash_setkey(NULL, ...), causing a NULL pointer
> dereference.
>
> Would it make sense to call quic_crypto_set_cipher() before using
> secret_tfm, or to reorder the function so quic_crypto_set_secret() is
> called first?
>
secret_tfm will always set in quic_connect(), quic_accept() and
quic_inet_listen(),
quic_crypto_initial_keys_install() will be only called after one of
these 3 functions
is called.

The patchset-2 (the following series) will give you this completeness.

> > +     if (err)
> > +             goto out;
> > +
> > +     quic_data(&l, tl, strlen(tl));
> > +     quic_data(&k, srt.secret, TLS_CIPHER_AES_GCM_128_SECRET_SIZE);
> > +     srt.type =3D TLS_CIPHER_AES_GCM_128;
> > +     srt.send =3D 1;
> > +     err =3D quic_crypto_hkdf_expand(crypto->secret_tfm, &s, &l, &z, &=
k);
> > +     if (err)
> > +             goto out;
> > +     err =3D quic_crypto_set_secret(crypto, &srt, version, 0);
> > +     if (err)
> > +             goto out;
> > +
> > +     quic_data(&l, rl, strlen(rl));
> > +     quic_data(&k, srt.secret, TLS_CIPHER_AES_GCM_128_SECRET_SIZE);
> > +     srt.type =3D TLS_CIPHER_AES_GCM_128;
> > +     srt.send =3D 0;
> > +     err =3D quic_crypto_hkdf_expand(crypto->secret_tfm, &s, &l, &z, &=
k);
> > +     if (err)
> > +             goto out;
> > +     err =3D quic_crypto_set_secret(crypto, &srt, version, 0);
> > +out:
> > +     memzero_explicit(secret, sizeof(secret));
> > +     memzero_explicit(&srt, sizeof(srt));
> > +     return err;
> > +}
>
> [ ... ]
>
> > +/* Derive and install transmission (TX) packet protection keys for the=
 current key phase.
> > + * This involves generating AEAD encryption key, IV, and optionally he=
ader protection key.
> > + */
> > +static int quic_crypto_tx_keys_derive_and_install(struct quic_crypto *=
crypto)
> > +{
> > +     struct quic_data srt =3D {}, k, iv, hp_k =3D {}, *hp =3D NULL;
> > +     u8 tx_key[QUIC_KEY_LEN], tx_hp_key[QUIC_KEY_LEN] =3D {};
> > +     int err, phase =3D crypto->key_phase;
> > +     u32 keylen, ivlen =3D QUIC_IV_LEN;
> > +
> > +     keylen =3D crypto->cipher->keylen;
> > +     quic_data(&srt, crypto->tx_secret, crypto->cipher->secretlen);
> > +     quic_data(&k, tx_key, keylen);
> > +     quic_data(&iv, crypto->tx_iv[phase], ivlen);
> > +     /* Only derive header protection key when not in key update. */
> > +     if (!crypto->key_pending)
> > +             hp =3D quic_data(&hp_k, tx_hp_key, keylen);
> > +     err =3D quic_crypto_keys_derive(crypto->secret_tfm, &srt, &k, &iv=
, hp, crypto->version);
> > +     if (err)
> > +             goto out;
> > +     err =3D crypto_aead_setauthsize(crypto->tx_tfm[phase], QUIC_TAG_L=
EN);
> > +     if (err)
> > +             goto out;
> > +     err =3D crypto_aead_setkey(crypto->tx_tfm[phase], tx_key, keylen)=
;
> > +     if (err)
> > +             goto out;
> > +     if (hp) {
> > +             err =3D crypto_skcipher_setkey(crypto->tx_hp_tfm, tx_hp_k=
ey, keylen);
> > +             if (err)
> > +                     goto out;
> > +     }
> > +     pr_debug("%s: k: %16phN, iv: %12phN, hp_k:%16phN\n", __func__, k.=
data, iv.data, tx_hp_key);
> > +out:
> > +     memzero_explicit(tx_key, sizeof(tx_key));
> > +     memzero_explicit(tx_hp_key, sizeof(tx_hp_key));
> > +     return err;
> > +}
> > +
> > +/* Derive and install reception (RX) packet protection keys for the cu=
rrent key phase.
> > + * This installs AEAD decryption key, IV, and optionally header protec=
tion key.
> > + */
> > +static int quic_crypto_rx_keys_derive_and_install(struct quic_crypto *=
crypto)
> > +{
> > +     struct quic_data srt =3D {}, k, iv, hp_k =3D {}, *hp =3D NULL;
> > +     u8 rx_key[QUIC_KEY_LEN], rx_hp_key[QUIC_KEY_LEN] =3D {};
> > +     int err, phase =3D crypto->key_phase;
> > +     u32 keylen, ivlen =3D QUIC_IV_LEN;
> > +
> > +     keylen =3D crypto->cipher->keylen;
> > +     quic_data(&srt, crypto->rx_secret, crypto->cipher->secretlen);
> > +     quic_data(&k, rx_key, keylen);
> > +     quic_data(&iv, crypto->rx_iv[phase], ivlen);
> > +     /* Only derive header protection key when not in key update. */
> > +     if (!crypto->key_pending)
> > +             hp =3D quic_data(&hp_k, rx_hp_key, keylen);
> > +     err =3D quic_crypto_keys_derive(crypto->secret_tfm, &srt, &k, &iv=
, hp, crypto->version);
> > +     if (err)
> > +             goto out;
> > +     err =3D crypto_aead_setauthsize(crypto->rx_tfm[phase], QUIC_TAG_L=
EN);
> > +     if (err)
> > +             goto out;
> > +     err =3D crypto_aead_setkey(crypto->rx_tfm[phase], rx_key, keylen)=
;
> > +     if (err)
> > +             goto out;
> > +     if (hp) {
> > +             err =3D crypto_skcipher_setkey(crypto->rx_hp_tfm, rx_hp_k=
ey, keylen);
> > +             if (err)
> > +                     goto out;
> > +     }
> > +     pr_debug("%s: k: %16phN, iv: %12phN, hp_k:%16phN\n", __func__, k.=
data, iv.data, rx_hp_key);
> > +out:
> > +     memzero_explicit(rx_key, sizeof(rx_key));
> > +     memzero_explicit(rx_hp_key, sizeof(rx_hp_key));
> > +     return err;
> > +}
>
> This isn't a bug, but these two functions are nearly identical.
>
> quic_crypto_tx_keys_derive_and_install() and
> quic_crypto_rx_keys_derive_and_install() share the same structure: derive
> keys via quic_crypto_keys_derive(), set AEAD auth size and key,
> conditionally set the HP skcipher key, pr_debug, and memzero_explicit the
> temporaries.
>
> The only differences are the member names accessed (tx_secret vs
> rx_secret, tx_iv vs rx_iv, tx_tfm vs rx_tfm, tx_hp_tfm vs rx_hp_tfm).
>
> Could these be unified into a single static helper that takes
> direction-specific pointers as parameters?
>
Looks possible, and I will give it a try.

Thanks.


Return-Path: <netdev+bounces-266906-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ML9dJstCsmlFKgAAu9opvQ
	(envelope-from <netdev+bounces-266906-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 05:36:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0454E26D242
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 05:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B80DF3069AC9
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 04:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F1639656A;
	Thu, 12 Mar 2026 04:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4ZPOxuZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D614C3382F7
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 04:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773290185; cv=pass; b=cMDTjs/yYV8BxmqETUQqdSRDff8KVHelSICOUvkuQ985v4gH6gs5SOK4mN15kbfGtCJ9ZYHiqOhVBiqdZhVkqz9UiD5e5Lxt3aKuaqcH7bpW7apMRJCj3GQeZ+PrDbAHbbNkqqsEsqX5BL0PO802QlmuR/uMFa7Olx94PGlWgn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773290185; c=relaxed/simple;
	bh=r67LYn4BVEqa3wFpvM44svB0D4IlUD9XKYF0XBEHoqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MtYW3L04DHFlk00MvgFFOriYVXhCCHkq3WIHhZo7Hclk9yPC+HTbqB1YOQaJPCimkoJVXE/LPSO14idxvusyCWhEU8f0T7oF6tNQ5xgV8kKfeltN8D05+u14j+HlCxX3l38UKqk45/00WjPTUmPh0d4uW2uSRKZ4ed7rNJgYp/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M4ZPOxuZ; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b940f962a82so79709166b.2
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 21:36:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773290181; cv=none;
        d=google.com; s=arc-20240605;
        b=RJfkMhdbNnK5YCYnHQIqQh6QG3//dq6P1KREyhoLF59SMipHArB/SGI4ZQfo3WPUCS
         /RBzR7GWA9G1djvd0zqWZh3zrE/gTHTosQ6luVd0OxenF1NQksY0tx3YSF7ANxA2ZztS
         dm4JlHk0RpdG17zugOFlLJJUFLy/Rmr+FbC88qK4sUsEoh6XbpCrMUF/TNKMjAxeOgcR
         RmVoNMEfXaxzhvWR0F45XperIt5hSVMVdLWjtw52WVD54YvmdzUEchnFnDiCOsyyKsNo
         UzXEFu7Hu7P5NAb3kuElCJT2aWSjfVzw4EkS6+zpc0TjaD3D7wVM+43W/l6iV+5c0gHs
         Q9RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jgU9UvY3lu44I+ej2GaFAalB2RjKnqqwQmuzGn2hqBA=;
        fh=putQQOZotbF+UX2a6oOEwa5kS52JrqFWjy8BKLTGc3o=;
        b=iqrRERbC9DzDWOhOn0cX+rDlVAhqJBpMZ3mTWRG8KoaD0sdIMdNFWq85wfBv8T/BTL
         sglYRJQK5nAjqE3tSAjgaO6wzirefjYCZHcIESbl8vOhyINdviSvnXptJuH7Odcx4tm+
         EWgYFAwHPpbwNV+sdjnFDr8o8Tb9YgTjYDbXpxxgJ1A9zmrfN2c7IJvi8xJuT4/11RUB
         AhixT9FDD0GI3cUoFwoTJC9ttEU4K96mRFtJwAsvu4RXa14FtrXU5E3/wUjS5NMoJJ90
         POZ7YFYkQs4Fc1LiEOlEN22Ft6VjVP3R83FjnPnKPsEPPjXC6Id9NoMG7O8ZedNc2UtT
         GZPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773290181; x=1773894981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jgU9UvY3lu44I+ej2GaFAalB2RjKnqqwQmuzGn2hqBA=;
        b=M4ZPOxuZ8Ak5NhzNj08qLtnTd/i9PagVJUna6kmZmPa5C2NNcXIrij7gMBT3fBVi/P
         6NX6jwzOxLjwYL0RzlIZsJ6Dgbnt87rC4P+BiJGU8Bl54Y80sq1swAU3ck2vCv5tn1xc
         XaU7xoyDlRr3qVWIp7A8uyisyb/Qj5pyNV1pFPZUclrfEv+PPWHvxglbdmVz0mhN/u9m
         1vSP4y1rNEVu5IwooM5siLFOhM5hhXu0jrsIRR3AhGtd+9Ee7DrWyP4kq1UdcH7X0uns
         lcdSyWqrvj8pgbXN6yiLFBdpBAqgF4wiaHDLjVRPxpV8qRRaJmgLeC/QXTdwmLuHv6NH
         C4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773290181; x=1773894981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jgU9UvY3lu44I+ej2GaFAalB2RjKnqqwQmuzGn2hqBA=;
        b=Cg3JFI4A+NSqml7JiXGTZzGo9TkqkTdoPK6ebYKFdkjax+H2FMD8V6Ew8YQUp+tjeo
         PMx519W6S2LIUOn5X+3UPj1yaQLFeHfjG6LCLKeb7c4dlEma8mJDDIJ/8tKjdQHo/LYL
         ehWnWeZzFtv0IQeru58oqNM8JM0XdBZtp5Xt+gErB8WnKPfEU1bmb7kDgCyFMATTV5DK
         4YA9+hpYzC2b3XlsYjzoxp/s7BDHkIM+aI23m4rYi/m+cnpT4hj2+kDoPgWgIJzWV+Tq
         wwOSi4eJ2dZ5YhhOh3R8iTcQkKP/utl4PnrpxzkFGb1Af5mu4L1KTwobMP5ESsSIy2it
         1udQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+Uvh3pF0qFFRvGLMnznRhfneoqL1NMQLiuhOIKTBMJbK2ZaE+7J7UZbUSdTWPXqZtfOKktZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNacydrFeXpSN/GOh8Q5HrIXqSvcOiCYQWvb6fJw0/H4cseQ9y
	xHE3I8zCNH1c1m/hwGfFjEn0ZlLA/hMfFeQRxQ13TF3Y4AFGgHw8ygQkhky/Yb5h40fkUK2iEd8
	kL6rS9EprXR43y+Cyv9f7uYUd+GMrETs=
X-Gm-Gg: ATEYQzzHcPYsPdTW4kpNWIYo2qkpwpKnfxRCbmCKxOn5bM//z0/6YU0YbVeHJwfZNiv
	2bJwVpR+qXw8SmzBIGTk57y8Oqsfsgbjs8TrMnOusv1PDS5/trALVb4WhFO79j8Ajmem5ftJzpW
	ezRhJPhZuasv0iBTzYvIUYspSlWJpwb7hz5RoXC4QRJrFw73vo6MGGjcIn3o4HkP12L4onWixan
	B0C6E7TlLTRpZ7mVR3shXqN4/3u9gcZ91aOZBlOrCwXO98c06CGVxW7Da3Kp/4qRbzSQ5YZ+q3O
	rj6zHIZ6P4t5QD7MUVCoy5E4cmLk0+mLnr0DxNeKNi+esYf6
X-Received: by 2002:a17:907:747:b0:b94:2345:3e6a with SMTP id
 a640c23a62f3a-b972e58c7edmr279717466b.48.1773290180923; Wed, 11 Mar 2026
 21:36:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312014804.5083-1-cel@kernel.org> <20260312014804.5083-3-cel@kernel.org>
In-Reply-To: <20260312014804.5083-3-cel@kernel.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 12 Mar 2026 14:35:53 +1000
X-Gm-Features: AaiRm50goo0thwPi9iRQE4KQ3LIpAI9ZnjrIB56iy3Lx0LeVrfHR2dcpQr9Qs-k
Message-ID: <CAKmqyKMLA6qBOdxTCayDzujDz4=4v3qcXGzHf5pwBH0by=O67Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] tls: Factor tls_rx_decrypt_record() helper
To: Chuck Lever <cel@kernel.org>
Cc: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net, 
	netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev, 
	Chuck Lever <chuck.lever@oracle.com>, Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266906-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,queasysnail.net,vger.kernel.org,lists.linux.dev,oracle.com,suse.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alistair23@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:email,mail.gmail.com:mid,wdc.com:email]
X-Rspamd-Queue-Id: 0454E26D242
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 11:48=E2=80=AFAM Chuck Lever <cel@kernel.org> wrote=
:
>
> From: Chuck Lever <chuck.lever@oracle.com>
>
> recvmsg, read_sock, and splice_read each open-code the
> same sequence: zero-initialize the decrypt arguments, call
> tls_rx_one_record(), and abort the connection on failure.
>
> Extract tls_rx_decrypt_record() so each receive path shares
> a single decrypt-and-abort primitive. Each call site still
> initializes darg.inargs separately, since recvmsg sets zc
> and async between the memset and the decrypt call.
>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  net/tls/tls_sw.c | 29 +++++++++++++++++------------
>  1 file changed, 17 insertions(+), 12 deletions(-)
>
> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index cedcc82669db..81e0e8aaa6f9 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -1832,6 +1832,17 @@ static int tls_rx_one_record(struct sock *sk, stru=
ct msghdr *msg,
>         return tls_check_pending_rekey(sk, tls_ctx, darg->skb);
>  }
>
> +/* Decrypt one record and abort the connection on failure. */
> +static int tls_rx_decrypt_record(struct sock *sk, struct msghdr *msg,
> +                                struct tls_decrypt_arg *darg)
> +{
> +       int err =3D tls_rx_one_record(sk, msg, darg);
> +
> +       if (err < 0)
> +               tls_err_abort(sk, -EBADMSG);
> +       return err;
> +}
> +
>  int decrypt_skb(struct sock *sk, struct scatterlist *sgout)
>  {
>         struct tls_decrypt_arg darg =3D { .zc =3D true, };
> @@ -2132,11 +2143,9 @@ int tls_sw_recvmsg(struct sock *sk,
>                 else
>                         darg.async =3D false;
>
> -               err =3D tls_rx_one_record(sk, msg, &darg);
> -               if (err < 0) {
> -                       tls_err_abort(sk, -EBADMSG);
> +               err =3D tls_rx_decrypt_record(sk, msg, &darg);
> +               if (err < 0)
>                         goto recv_end;
> -               }
>
>                 async |=3D darg.async;
>
> @@ -2294,11 +2303,9 @@ ssize_t tls_sw_splice_read(struct socket *sock,  l=
off_t *ppos,
>
>                 memset(&darg.inargs, 0, sizeof(darg.inargs));
>
> -               err =3D tls_rx_one_record(sk, NULL, &darg);
> -               if (err < 0) {
> -                       tls_err_abort(sk, -EBADMSG);
> +               err =3D tls_rx_decrypt_record(sk, NULL, &darg);
> +               if (err < 0)
>                         goto splice_read_end;
> -               }
>
>                 tls_rx_rec_done(ctx);
>                 skb =3D darg.skb;
> @@ -2380,11 +2387,9 @@ int tls_sw_read_sock(struct sock *sk, read_descrip=
tor_t *desc,
>
>                         memset(&darg.inargs, 0, sizeof(darg.inargs));
>
> -                       err =3D tls_rx_one_record(sk, NULL, &darg);
> -                       if (err < 0) {
> -                               tls_err_abort(sk, -EBADMSG);
> +                       err =3D tls_rx_decrypt_record(sk, NULL, &darg);
> +                       if (err < 0)
>                                 goto read_sock_end;
> -                       }
>
>                         released =3D tls_read_flush_backlog(sk, prot, INT=
_MAX,
>                                                           0, decrypted,
> --
> 2.52.0
>
>


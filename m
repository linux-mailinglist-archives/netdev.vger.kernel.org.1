Return-Path: <netdev+bounces-292121-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNGWF+yXFmq1ngcAu9opvQ
	(envelope-from <netdev+bounces-292121-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 09:06:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E79FC5E034D
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 09:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4B5ED3076A68
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 07:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1923B7742;
	Wed, 27 May 2026 07:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cwX3jN73"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088CE305675
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 07:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779865390; cv=pass; b=DkdpUMMd32jdsgkgHOw8mTGpbExcCHv6ZKDWP7oVRXTDCbB7T3amI6Y0j9ZN6H3wVh1OnshNRhS9633nKkUQCn4sQUeJF2ZDopucHffl/B0K3QPiQO60ROi5QJkQj0krC7975m9Q4x0oMtveKT7bfaBbzofs2STMn9l/Lf+3ugc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779865390; c=relaxed/simple;
	bh=3zR0/hiGZ5zk5sjZu84HNs3iUXOsFWvgBJ9fNwyMtGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DsQAR9UueW9t3I4a7YYvsZ+ad9zsywDEblVgEC7G2lQ0nsydRuLKLbGG4EL/khzVcVZ315zLOZcqWg6xi7GgkuzEqXkz+oz0Z9i5dQKl+N7+HqBYc9ixlJz0ucteLMWKk8F9tHsr0l0y0fDuqB+uszG6MPrIVxhwuHCwaKAdqUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cwX3jN73; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-132c338a537so7621799c88.0
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 00:03:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779865388; cv=none;
        d=google.com; s=arc-20240605;
        b=lHkeme1fzJTiM5CKJMsTJXDKts3Z5MLNKyB7lrU9ApSbMCqtgmVa3M/qzfDCaj/fcn
         3oUt9jD806Zs86EublkRmilqjXMj8AaY5WdUhpfoj8/wYZscx+tQgI1GOKnKZxdlFqLR
         +BkF2HIZVzR+Vbfj/oNSau9UZXpQaxZ945NxX8nwFsfL/Pg9YTOgqkOFLd/fdtWVpfoA
         wGQ6iKvmpzCAs/a8hH0ar7I78qnpYs7jcgg37ZiEqvV6445zVEjZR/oj+maTSwkEQ12A
         VuP28BFxmDUMkAdmHpiF2Zh1I3/WAQhu4CdyXaL/8Y9OI6W2Qe8h/seLLJaCeziHlc9O
         18SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o1587O+nbv0Z++QExRTV/St5RdeYmeZ7o2BDq4KRWHE=;
        fh=Ac2SV/pD6yNQuRfKFr/zt++7Ch+A2szbXPBIFpwbLnU=;
        b=b6EzUGHtEv9XpKw2T4+6NrTyhnsgjpWRI502xWUIhuAVgr+VUpKpCNao14sSAjdQYh
         Op9tazLB5EvirPucGUmnlIaabs+u49w+dEMUX27vib1ginKgho7nG1rukECcceqWkpy2
         xMAwWEyDUkKYx3CFK1Rg6MVkHC4JNhPa4tcUkJykuvXYzPMP4Ima31tmWsIKunH4A4Qu
         IQYX91vqDeB6DGmuIhXDQ0KzcxP19M88cJD9KfMRZTop8fxEkDGUiFGEtN1coyUEVTg2
         WfJCf3G361huO7npixrBaVBnoxvGqNcw0vwWfBe80W4G/afQZOczJMz/hD2FLeGHYoMT
         WwEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779865388; x=1780470188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o1587O+nbv0Z++QExRTV/St5RdeYmeZ7o2BDq4KRWHE=;
        b=cwX3jN7326dFXXgnELvFLQK0Ju0aDpFMxHvdYrEuO4+ywqOZejJJSxWp3WjaxSpPBp
         pb2scCLQn65pkg8TD7lco09/nN9toa2bbOzkO9MjjPXjZ6IoG1zdbKIovL0WV2eGaatD
         cMHsIw6f1xEOHvW22O13v1zoLq7WBGQVaDbqJzjfiLpa+ef0OEPR5kiLav3jmFj92zgM
         monHiwGDRQgVAVgwjIVUzZjoBNbb2fLkn0agez/OAvbHkoEQargSaIDOvyFMbmTOywMW
         ON9qcQiw+VP5VaAEJqgv1xKNSCQznoAb7ocjkK2H7XZptpW71p1bxN4Q9DkElkPR+k+5
         qmjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779865388; x=1780470188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o1587O+nbv0Z++QExRTV/St5RdeYmeZ7o2BDq4KRWHE=;
        b=hLXEtn9i8gd1HAI7V83Kvjs8jHBEd6ij42n8lL6zKc57WARVIndXn9KfLMs1UKbSz8
         v1/lqUx0VpBXTx7Vf0hv59vXCSJirQhKd94by3sf3hcckvPhY6b4/pueEqaqL0n6kJw+
         ErRWwF+JVTHq0CaLfvYMBfe2rQdOHEohue7e4X3ff0LWSdgUT1FZ94G+fed4iIagI7Gj
         kTQTzCMX1axN5B2DbsMnQ6urMbEitq1vF59Z88Zxo5yLqqtdrGeB9uPU63nHC776JJkn
         1qXH7xU874gpfS6XbIBkr0fRWiYKXHibvV4ksANSNyYkPKHjkK0bx/So7UNK9Rjfzml5
         958A==
X-Forwarded-Encrypted: i=1; AFNElJ+ukW8cyayTqunF1fQFOSGsgWTljCCRVg63lpXkwULlY9aUFDlQLMDuoRg4P59/QOQQxS52ndg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+JUpaUIHdMxSykIE6nKa+SXiGUJBKvbE5iJNw+ZQftqF0Rypt
	egimTaJ2PmOV97r1zL7UFIk1rKaR9MPOuoSgUjleJGbC88BZQqHZuUrlbRYPuM7I80o3ayg8ykY
	NfGppX7ftO5oV7fHHe1FPzC37U0Gm3kmsQw2c1wco
X-Gm-Gg: Acq92OH8H4QB/KyIHztjLHXITsVvm5edKma4J11ZnNM76n9oPYFpXN0rHsV89kP8g63
	WprNpS/35OhxA5bNc+DPgOCttBlFzfPJzXIDXYvzHOIiXaKWOhZiZqYpZlHFqXWSpnq1hnC+4IY
	Qd/YRvlpfQFQm7/jr244teOgJv9agcwFNZ11McTsjMCEhM8M+39Pxur+6j+lwPnGbXpn4vz+XhL
	NKG26uMEInGoia4RjdfJW2sMu3t89SrWEpiyzGq+M857tsSa1d0SzIRqOrbLvcxxQ//QHlDWJ2Y
	ukDQtwjT/+rJ1cDlheDQ/MdERdqaMGcMPlcuRBfP0kXaesDuDm6cb7D5rM9cw01obzK38FcBa2o
	8zNi8hfOARM1avoKFy6XSLocfzjqImF05LjRPb5hlP6O8YFyvdKyKW1kZbSwQsg==
X-Received: by 2002:a05:701b:241b:b0:132:133f:63a7 with SMTP id
 a92af1059eb24-1366129c82cmr4190151c88.8.1779865387377; Wed, 27 May 2026
 00:03:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527065342.2463433-1-jianyu.li@mediatek.com> <20260527065342.2463433-2-jianyu.li@mediatek.com>
In-Reply-To: <20260527065342.2463433-2-jianyu.li@mediatek.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 27 May 2026 00:02:55 -0700
X-Gm-Features: AVHnY4K8KrfS0dp6J0nn678O83X4toikUVmK8774N0_wWE99FyU0BxZlOnh_bsA
Message-ID: <CAAVpQUAz1SLa7oGYb4Wh3d5W0_hRnq5h=oOQfgChvo+dtWBdVw@mail.gmail.com>
Subject: Re: [PATCH net v1 1/2] af_unix: Fix inq_len update problem in partial read
To: jianyu.li@mediatek.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	black-ch.chen@mediatek.com, ivan.tseng@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292121-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mediatek.com:email]
X-Rspamd-Queue-Id: E79FC5E034D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 11:54=E2=80=AFPM <jianyu.li@mediatek.com> wrote:
>
> From: Jianyu Li <jianyu.li@mediatek.com>
>
> Currently inq_len is updated only when the whole skb is consumed.
> If only part of the data is read, following SIOCINQ query would
> get value greater than what actually left.
>
> This change update inq_len timely in unix_stream_read_generic(),
> and adjust unix_stream_read_skb() accordingly to prevent
> repetitive update.
>
> Fixes: f4e1fb04c123 ("af_unix: Use cached value for SOCK_STREAM in unix_i=
nq_len().")
> Signed-off-by: Jianyu Li <jianyu.li@mediatek.com>
> ---
>  net/unix/af_unix.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index dc71ed79b..2f0b73598 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -2886,7 +2886,7 @@ static int unix_stream_read_skb(struct sock *sk, sk=
b_read_actor_t recv_actor)
>                 return -EAGAIN;
>         }
>
> -       WRITE_ONCE(u->inq_len, u->inq_len - skb->len);
> +       WRITE_ONCE(u->inq_len, u->inq_len - unix_skb_len(skb));
>
>  #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
>         if (skb =3D=3D u->oob_skb) {
> @@ -3056,6 +3056,10 @@ static int unix_stream_read_generic(struct unix_st=
ream_read_state *state,
>                 if (!(flags & MSG_PEEK)) {
>                         UNIXCB(skb).consumed +=3D chunk;
>
> +                       spin_lock(&sk->sk_receive_queue.lock);
> +                       WRITE_ONCE(u->inq_len, u->inq_len - chunk);
> +                       spin_unlock(&sk->sk_receive_queue.lock);
> +
>                         sk_peek_offset_bwd(sk, chunk);
>
>                         if (UNIXCB(skb).fp) {
> @@ -3067,7 +3071,6 @@ static int unix_stream_read_generic(struct unix_str=
eam_read_state *state,
>                                 break;
>
>                         spin_lock(&sk->sk_receive_queue.lock);
> -                       WRITE_ONCE(u->inq_len, u->inq_len - skb->len);
>                         __skb_unlink(skb, &sk->sk_receive_queue);
>                         spin_unlock(&sk->sk_receive_queue.lock);

Could you combine the two chunks above like this to avoid
locking dance ?

                        spin_lock(&sk->sk_receive_queue.lock);
                        WRITE_ONCE(u->inq_len, u->inq_len - chunk);
                        if (unix_skb_len(skb)) {
                                spin_unlock(&sk->sk_receive_queue.lock);
                                break;
                        }
                        __skb_unlink(skb, &sk->sk_receive_queue);
                        spin_unlock(&sk->sk_receive_queue.lock);

>
> --
> 2.45.2
>


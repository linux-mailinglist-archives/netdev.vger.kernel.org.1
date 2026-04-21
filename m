Return-Path: <netdev+bounces-280006-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KObVIOUD52lo2wEAu9opvQ
	(envelope-from <netdev+bounces-280006-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 06:58:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F02CC43651D
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 06:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F8B93017275
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 04:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C004274FE8;
	Tue, 21 Apr 2026 04:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C/rylQWG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9D51E633C
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 04:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776747489; cv=pass; b=sigvNaVkSyIE5nx3hY6yX8AKi25jxzRmKyqMrO0zJY4fG0BqPp9d2mPMV0hE9uEBQHdwWOpKTGsKCX890bCRc4J3Kgz4m4Z5KO23pNjAt+Lhjb/QCeK2bCWvOnlUzskmU0ZQDjHgIVTy95chrzDKrATNgO2zXlqQH5JGP834+vs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776747489; c=relaxed/simple;
	bh=6oN8ca+Y1Sm9HOp7hoShrVCOOTdt4BYLqHtFTXpcXQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s+VwgH5HmVpoX1FqmZ3OKsIT5+S8LDSTiAn7hTt4MDNJGzblXLazploepfUMDF4S8QzUOF3ybbXtiUBKUc5BFCh85PSoosEd5fCe/TDjHL5dOhUjVRWf60oiEKaqXkjqhgS/iGI5y9y+EPttlhCnhkbmP51eq8MEMYKCna/Ce2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C/rylQWG; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50d87610513so44165761cf.3
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 21:58:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776747487; cv=none;
        d=google.com; s=arc-20240605;
        b=dO7z/DiYb8M7+4TFHS/Kvdcj65hTTKDLbib62EKp5svqIso64yCKViaZyp2sDFsu1x
         VGODOzCugXW3F6i46QlRV/4DqeWt/GlKnNyeCIqlaLnCTSkRvxkR52o2aI0AvsXR8asQ
         nNCjehQ8OUoQXRaWbysLNvGFLtxXfsvzKPkwaXrn9p5FCTyQBjazEJGoaN8ybcQnpTch
         N5V8khhL5MuyG52/FF4j1xEevsu0/ol1UXmFfr9ROSH9pUAsn5m94oOT8XxelwhJUJwD
         zLY+rbAp0V4yZFl8NAczv+4uZI2ZV1i+DCg+7+vN3q3r4rYh/KGbD0c6naRNirQnWIZ6
         1S7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8w24vIkMJrOzBU6KELKeW0y5+vTpPKoGnfDDc17vexM=;
        fh=YSbP/HdkmA6G7exx7zpC/Wc1FNTR0Kk+R8zqmNZ4CHU=;
        b=RjllaA9t5V7ELkjJTAfJgaWwjoaxRu5zUTNIUlqF424NF4F0ZDQrQMytSRtuMQFq4y
         XezTmU1S0Im2o31OUDNZcDisFqZ5+ucoLewu+pjigKREQUp8opZzMgyPoyhDMq1BPxJL
         2QQYmkWicSCCMYdwRiTBqGRlSkKcbtUwOiB+ETy9BV5bYjhGt6PuOx+ctx1Pxlidz0MX
         +kB9I9BzaT428kVer7JsLJK41QEHwP6bkccEZ7XTKY0ymzsYRXW8317nB+K2e2cyvwEQ
         LGGXyboIWjFWUYWsdh5HWNxMV9Bke3n7v5yH78/h0FeV8h3AhqyyB90iT0yOOZzUAP53
         RNuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776747487; x=1777352287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8w24vIkMJrOzBU6KELKeW0y5+vTpPKoGnfDDc17vexM=;
        b=C/rylQWGdIS3IEK7mKnGuJyxScZG8p1JfA60WSzyEfcqbl7F5k9ibBfraPPOh6rpmV
         MCyU0/LL1I8LB4ST107rbBOc6U3rmEVDxerjCniDr4U964H+N6yIFh/tI/46W3DI7Z3e
         H/jsFl0ZSlnLw1xvpE/285s5q1JwSM0SpqAVOGxuQPvqFAvLIPSdSJpdVjwhPpk+SQrF
         6NtiW0juXuDTOP1xhCKUn+OPkMDuNEkmF6Mcafg21aAQU6uGPl2JWCIo7vd3BhrReA4c
         V7Ri+blbrResKKvRWN+9ijVVzRx8UaMtBAEpogFeZgLxhuhfq46FHVptj2gZ2qkmmvDF
         CziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776747487; x=1777352287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8w24vIkMJrOzBU6KELKeW0y5+vTpPKoGnfDDc17vexM=;
        b=BG34SW95K8yjpZu0qYXN4OEy69lX25duzAQKTugbXW/O/awDZr9i1yuutQ4zPrGhYd
         JsC+a1OLCcyiMrfAZ7hxTliAU4P6NQuZiQ/KOFuuafNENnQQPGqYJ+2a7obQ9ZubjZaa
         Nlxe2fD0UUDTepv9u2r+va3hKcQ3CEryLuOkwff2iLBOSVpAtIZO1+VQPgaLdl6NJhuB
         e8PDf4J5wWRkdyO4ULIbPlDr3eCDQGoDnbAP5ghB27scaEXs/J6XppJ18mVYO0kw7qmu
         F6xBKJeeV8vhGGvYUgvmAPp9GcKxoSW+DVseYJ9W4QtCOf1nH4rXNtQoJYMsCirhibeG
         wumA==
X-Forwarded-Encrypted: i=1; AFNElJ8+B0274vFoXWlIeBqOU2+jMHLdxqMENBH8xPnxlV4PaHGrFiFCSfQWKrKgawuBwj50KfxuSIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEpbi60M3BaqmsK9K5UeI1qWhwAUWdJWh58pkuBujV8yDIN3h5
	rqpNw6nLbPPymhi1RdaVhU+LpOwbyXocUjT55qNg59OJPaHsLQtIsnaA9+bECJca5TfkkbaSaAM
	3JZAwqP6nyPmEEA3ZSNMw2VXI7eNzuHGdq0Uf8UaF
X-Gm-Gg: AeBDieuW+vTl1fd1tXhYK1+uKhMnFv+wkvAmtick7AURY+AMg6S1SzqVVQl971OLjwA
	VBcSLKFLb63MK3dEe/BfCTDCd3yJjBlvovfckj137ngGZQLbXTBQOZvz5yMzEUiuoHAZAfRcKBo
	kvtgg+cPjf6biXOY2jru1q4l7KmG3+Jn+XpfdJohr1XyhPN5OWroGe+GSMjctj8Ap2NW3Y6uELj
	KNwD4iFxGtxbdQ4H6bt0mL69OpmyBzTdu0HfWfm8pfLwuFOkZSdnitlb/Wm+Lwg4yChvAkVAGpj
	p7G2fBjIgdw7z7kckRink3TRxm3CyszhtEg+f1NjEMYsuHKcFsU3QE7HWNb4yPsHpeREbNqV8/v
	o71VUK9I=
X-Received: by 2002:a05:622a:586:b0:50b:404a:746f with SMTP id
 d75a77b69052e-50e36f2274fmr238071111cf.58.1776747486728; Mon, 20 Apr 2026
 21:58:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414013634.43997-1-ahacigu.linux@gmail.com>
In-Reply-To: <20260414013634.43997-1-ahacigu.linux@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 20 Apr 2026 21:57:54 -0700
X-Gm-Features: AQROBzBGGDfWNHNAt4XG0o2GBMwAH5wpqckEZxZq0XwrIb5XFjUZSygzuanVSoM
Message-ID: <CANn89i+vq9O8PJZaDf=0YjcKTM8=-64TcUn-i-F4siGKAMKz+A@mail.gmail.com>
Subject: Re: [PATCH net] tcp: make probe0 timer handle expired user timeout
To: Altan Hacigumus <ahacigu.linux@gmail.com>
Cc: Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Enke Chen <enchen@paloaltonetworks.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280006-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: F02CC43651D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 6:36=E2=80=AFPM Altan Hacigumus <ahacigu.linux@gmai=
l.com> wrote:
>
> tcp_clamp_probe0_to_user_timeout() computes remaining time in jiffies
> using subtraction with an unsigned lvalue.  If elapsed probing time
> already exceeds the configured TCP_USER_TIMEOUT, the subtraction
> underflows and yields a large value.
>
> Handle this expiration case similarly to tcp_clamp_rto_to_user_timeout().
>
> Fixes: 344db93ae3ee ("tcp: make TCP_USER_TIMEOUT accurate for zero window=
 probes")
> Signed-off-by: Altan Hacigumus <ahacigu.linux@gmail.com>
> ---
>  net/ipv4/tcp_timer.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> index 5a14a53a3c9e..4a43356a4e06 100644
> --- a/net/ipv4/tcp_timer.c
> +++ b/net/ipv4/tcp_timer.c
> @@ -50,7 +50,8 @@ static u32 tcp_clamp_rto_to_user_timeout(const struct s=
ock *sk)
>  u32 tcp_clamp_probe0_to_user_timeout(const struct sock *sk, u32 when)
>  {
>         const struct inet_connection_sock *icsk =3D inet_csk(sk);
> -       u32 remaining, user_timeout;
> +       u32 user_timeout;
> +       s32 remaining;
>         s32 elapsed;
>
>         user_timeout =3D READ_ONCE(icsk->icsk_user_timeout);
> @@ -61,6 +62,8 @@ u32 tcp_clamp_probe0_to_user_timeout(const struct sock =
*sk, u32 when)
>         if (unlikely(elapsed < 0))
>                 elapsed =3D 0;
>         remaining =3D msecs_to_jiffies(user_timeout) - elapsed;
> +       if (remaining <=3D 0)
> +               return 1;

I do not think this chunk is needed ?
If @remaining is signed, then perhaps change the following line to:

remaining =3D max_t(int, remaining, TCP_TIMEOUT_MIN);

Also, it would be great to have a  new packetdrill test.

>         remaining =3D max_t(u32, remaining, TCP_TIMEOUT_MIN);
>
>         return min_t(u32, remaining, when);
> --
> 2.43.0
>


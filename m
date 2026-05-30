Return-Path: <netdev+bounces-293299-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MnfsEnRjGmpC4AgAu9opvQ
	(envelope-from <netdev+bounces-293299-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 06:11:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B1F60B377
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 06:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F41C0300BC4E
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 04:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9BD344DBD;
	Sat, 30 May 2026 04:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jOYAh8Jo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB6D2DF132
	for <netdev@vger.kernel.org>; Sat, 30 May 2026 04:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780114284; cv=pass; b=BaX/JklG7NLqXidEckIYyQsqUktCRXcF3G7y4Mf6U2at0Fwpu0iOir0Cy/PUAIvqnu5d6B3GhBquDkUkcLduTC36J9F8aOtGZ5SpioQLSQmBns8Fh02PzSm/O0Vn3QRMYpcrnuMQE+5EwX05Wq6iduoRNFwPQgUSRdLr/LO2wiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780114284; c=relaxed/simple;
	bh=8A83G6YImYKj65RHthflqBgXis4k9f4oqy3yFwoZPtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L4dhPAUu/y5VWBI9ILysum+06Njp72/1u7PBagVRw5IkgMCGeSqtBmx9a57gmA4Q7F3UG05YTlWWeT9Ih9zFX+04G0pMHBrefa0Ckbh6HJPD1OlEYxSs9qPRbsTJ47UPItlLOJtK8Fns/VXvezudyaFAsOiFxb8BzvYcya26C9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jOYAh8Jo; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1363e78746eso11223055c88.1
        for <netdev@vger.kernel.org>; Fri, 29 May 2026 21:11:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780114282; cv=none;
        d=google.com; s=arc-20240605;
        b=bF93chzg+1sWFMuKoE1SsU+KjpbX4IMoHJSHYQnlxtVUsrSYJBGMgaiJ4RHifAaeOj
         zKqlDpPuOxUg48939b5fCVlN0fhtmzzXkti5XG67A49nWFef8OzeoY1sj50YOcdhIxm9
         eeuxS4FaGZ71A323cPvKDKApz1tQmy4InLY651k2DxEQO+4gCBy22CyzXKASlermIMuh
         Mj5bmRztQPzb1/RXIH8C3SK+9JdqqdbyjQMzkSQTHoBFZmSniLwDKG6QcN59y85A8Tbn
         GuMKNENkaF7kZXMKfMaJM+6Q0LIibVGJp59seh4TJgusEIT1NINzWmjA1I7XaB47+2Iw
         qu1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lhXDZe5HipJJsdvyTs8WRQPvcFgQOnMz2fCQxwZYhDE=;
        fh=S7ghAkzCAlO6DlWtcDc6C64/+y3GNmVTcCR7xsZZipM=;
        b=KbddOsO2i9bhfzgR6Mgk6H87/PfSIZNQhfHsj902Ru4S2UHMPfm3JX5gTnLrZE07cx
         Qhbc64oJr6zV/VC9FJ9gTJ7kCAojZAve1yW7uVVQ16bm8nIVXLGz1rwIalMyagS5cvOg
         /uoDDqht+DWZAsRhsxcX2K4PblYQwD+qZS2tOz883VacFfcBPZ0mFMmC/BbHd9+kmr3Z
         VeKWm1BV+yGDLw+X182qNuFinUxzwB2DzvJj4q3Tbv1V/BroC/CNrjuFuUt0YyTcBE5t
         l2yCsPGfE+dqx8ORnVv48acuc5FpWONFwqfOlvMGkgws2BbPKqA/cFbrXKPmqW2WSsS2
         ZzwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780114282; x=1780719082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lhXDZe5HipJJsdvyTs8WRQPvcFgQOnMz2fCQxwZYhDE=;
        b=jOYAh8JoO6YRR5HtQf4F1I+Sonc2we0bHpKpR9oBCtWjurVdpsaevj0u7Zmpf8bpum
         BmL4zOUc2JfCa1ZopiYAvFVPNIqoHprltUiAlafXPUgitknXQRPLh+nHTQvlJgN+tBFv
         1+GY4kbM7TAE8PnjNcB4JFzwirsiUDm+hdsbrC97hdkKtLLTv70I2EgwoDmQaJxbjGdM
         hWGdkza7HF/adN6J8l0+LwZDSPToOW/E72FzVHaHwv233XX9MnpK99VuIt1k9QCGbozW
         F93Ypx3kxfnamB3ChBLqu/rxYnu/YrY6oosqozcZJwV31JLfqH5JNFsGGjwXEieuTunN
         SSUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780114282; x=1780719082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lhXDZe5HipJJsdvyTs8WRQPvcFgQOnMz2fCQxwZYhDE=;
        b=tFkPbOA5okv8Qc18kdwmBQY64qdr545h+lE20EqB/urSQY0WSUhdWSnYz2TRGSTLRO
         UZl/ZHWyxGAHshgEEY0jcyWj5Q+PW8Eq0Uxvqvq1thjQZyAX4TCaamSYCPb1clc0JThb
         Yv9o3TILZtZMA1GAxIeM8yXBJfna86IMsw8N8A0p2mvsZRjzNebQnKuQ72EW9iZgkpGr
         OXi4e7Ss9coij1k2eP8ycYOAyEAMHyQXNwBudfOp+DcIF5jG8/YyVaE5Hc+4ya3pgUCu
         6E0Vo52aZf49n1QZGLqpYpAjXAnp6NSGrg9zlx5SC5ALi8s/HraXkrO83BaRc9rAh98W
         3J2Q==
X-Forwarded-Encrypted: i=1; AFNElJ9Yn9lwBmu+O0C0PQXDypI7HNAIABkqWyGSZR6z2QV0rjb/3FrpSHOg0vAvtIya+cy+qxMUmx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbvC+b9m4AlwqUiHxcYoEHqi618xm2cGYkXIm9/HYmIt7olzyi
	PU3jzc7lMMzdLYdkLFMcSIDU2KbyH5nYvD7TJiZwKpMPioWh1hvPPk8JUSiF1ZAYA5Yq9AOu7Sc
	xPmqNcz1Wo0MPifi0McD+lrtqkzQsI0gadq/wAYzl
X-Gm-Gg: Acq92OF6f04XrUoS6sYG4Z49ZGbkzF/aoBMI6sqpzVQIsMTvZLRmCKT29VIjTcmDsFf
	vVwlaUmmU8ekd70V/ZswKpuJwmxGM4hUf5oB347dGNRbisknl0H/xK70L65fw8SwpoLd7aSL/QN
	uRvVqajCr1ASC4vnh6shnMnNrE5uaV7CjyzTKApVA5pm3mJF3U6CEiUJPhZCC/N/EraJmyNBIC/
	tHoWGiC3+sTtFWh3+8TsqZSn+h0vm4bMPcOZjMmAp9xsbDu+RHBW5Ugdr+14vDL7K4/OD5d7Scz
	6wH6GO+csyTY4yBczVmDh1WisgZL72VCsr1+0zf4Stlf/s1Rlcv4k3bRXa43P/xCOOgth0z30g8
	H6UF9IoFJWyEaBziiSaC6Frt2Iode6NWAQQJLGTp38r94F643NhAreNPD25Cdo9E=
X-Received: by 2002:a05:7022:2513:b0:12d:ca31:f1b6 with SMTP id
 a92af1059eb24-137d423c4c5mr1067186c88.18.1780114281454; Fri, 29 May 2026
 21:11:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528081919.841-1-yanlonglong@kylinos.cn>
In-Reply-To: <20260528081919.841-1-yanlonglong@kylinos.cn>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 29 May 2026 21:11:10 -0700
X-Gm-Features: AVHnY4Iz8lG5ukGUWde2uClEPGIzNcepw9wlKp8bQtuGKSGUEJBppPYKntA_7cc
Message-ID: <CAAVpQUBBsOxHjxaisS9Qf4VdxSb6TbLT2HaAE5cgsC3HQ4qohA@mail.gmail.com>
Subject: Re: [PATCH] selftests/net: bind_bhash: fix memory leak in bind_socket
To: Bob ynn <yanlonglong@kylinos.cn>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, joannelkoong@gmail.com, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-293299-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 32B1F60B377
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 1:22=E2=80=AFAM Bob ynn <yanlonglong@kylinos.cn> wr=
ote:
>
> From: bob ynn <yanlonglong@kylinos.cn>
>
> The getaddrinfo() call in bind_socket() dynamically allocates memory
> for the result linked list that must be freed with freeaddrinfo().
> However, none of the code paths after a successful getaddrinfo() call
> free this memory, causing a leak in every invocation of bind_socket().

Note that it's freed at exit().

>
> Fixes: c35ecb95c448 ("selftests/net: Add test for timing a bind request t=
o a port with a populated bhash entry")
> Signed-off-by: bob ynn <yanlonglong@kylinos.cn>

The change itself looks good, but see the thread below.

https://lore.kernel.org/netdev/20260525125408.2bb8783c@kernel.org/
---8<---
Your email address seems to indicate that your real name is not "lazy.."
Please repost with the From / Author and Signed-off-by lines containing
your real (some approximation of "legal") name. Unicode characters are
accepted.
---8<---



> ---
>  tools/testing/selftests/net/bind_bhash.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/net/bind_bhash.c b/tools/testing/sel=
ftests/net/bind_bhash.c
> index da04b0b19b73..2bd100777448 100644
> --- a/tools/testing/selftests/net/bind_bhash.c
> +++ b/tools/testing/selftests/net/bind_bhash.c
> @@ -52,18 +52,19 @@ static int bind_socket(int opt, const char *addr)
>                 err =3D setsockopt(sock_fd, SOL_SOCKET, opt, &reuse, size=
of(reuse));
>                 if (err) {
>                         perror("setsockopt failed");
> -                       goto cleanup;
> +                       goto err_free_info;
>                 }
>         }
>
>         err =3D bind(sock_fd, res->ai_addr, res->ai_addrlen);
>         if (err) {
>                 perror("failed to bind to port");
> -               goto cleanup;
> +               goto err_free_info;
>         }
> -
> +       freeaddrinfo(res);
>         return sock_fd;
> -
> +err_free_info:
> +       freeaddrinfo(res);
>  cleanup:
>         close(sock_fd);
>         return err;
> --
> 2.43.0
>


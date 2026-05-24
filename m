Return-Path: <netdev+bounces-291154-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHogB92tEmoJ2wYAu9opvQ
	(envelope-from <netdev+bounces-291154-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 09:50:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FF35C1A44
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 09:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2ADA4300B130
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 07:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E75B3264E5;
	Sun, 24 May 2026 07:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YVxbv7u0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E6D282F3A
	for <netdev@vger.kernel.org>; Sun, 24 May 2026 07:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779609050; cv=pass; b=hCPqaGUe0/0z2UyjNZEo2V9mvEmq024wmtW2xU2r2FXAdvikmNmjbPeBMvEs9vASnlZwbuMlQwjPRudzzjKct6ShAedwlaTC0ULQLp8oVKIpTyQJOJp3bgSP0sl+8jAQwXDj+ifQgLMQ1u1bhJ3MzboCHwA1JWk2oyHjx0CnyXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779609050; c=relaxed/simple;
	bh=os4d8H3l07ZwBnGhH9CyjqnY/5J3cQQGVfNSykVQhs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=un4K5/B/r9DyaDJ0aDf8JkTOOvDYhKlaUPO8IVT5UWArkA5MmmG9GbNKnz9zfiYExXZODLvSqaU8+hdu0hJ2YyKB/W9mvvtIJSKKlobb6xh78PISREuqeMBbXUIZM48sDKTBR5wRaKEWawKaR30t7qwu0VEM6BrAdIaC2v4boAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YVxbv7u0; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-136b46c3540so468500c88.1
        for <netdev@vger.kernel.org>; Sun, 24 May 2026 00:50:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779609048; cv=none;
        d=google.com; s=arc-20240605;
        b=GWHJoKbHCYES+2/CBqjKzcYTw3AQ936fWGu99KoBQXHg/YmWFJk9XC/rKswwojRmEz
         YsKx9Cg1TI7nPN76wQnYQz5LWCUpdVSJ2WjzrIe3KF38kzFTRvaAEY5hFzrPcbmPjdSb
         GmA//kdMRYuxx0Nad15dC3jOyzGQ9RKlejPZeQ8TaBClYP6bzV87f1KKpDTPr5EQY/sm
         kv191RPZdUq8rfWPTFojP19lv+5rTsE6N7ZwNFBHWPsBAPHlR3ptp6SpdMH4VfrbjXF7
         CWUCD/KRugglDwWaftVUWTThAZGIeoO1cXm2/QI8SJQ751JEz4org+MalfkO5oyXG4si
         /Bxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=maSMJVpii3oREslg/+EI6BZ8V8Pxjvp9OUlS+TKXPfE=;
        fh=UAt/IEGU/IyBZvD+2Eg+1OfexfAM5RBRZx/lArVv+Ws=;
        b=Auq8A4+Wrv/fpVEaNKEQsJtTTFyg61fejVdeiAVLsy2es+687yEbnyqPkzfSQ+RX4G
         rNbYpJNrS5cZxYqUawDcScPJ6bdX+hd31bxgVEfJgFRR6hrJ9kdW5YmP34+VhjLJEWQR
         VvkR2fdGboe5eppNp85ljWCFYPefguET18aLQ/+fU9wpXgdHJB+e17Qrr7C3pFSX+qEG
         eeUJiafgRislwqoT5KLvrin5wkObkEGkGYpW8xex9e3eKw5caQrQIvKdvjE7WXvYPPJL
         Sz21L5UyeBdIHaAMaiCgMw8Q6tNVLgXoJDMhkVyhqf+ebtTdTy9SOhnyiny16cShYDoZ
         qqSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779609048; x=1780213848; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=maSMJVpii3oREslg/+EI6BZ8V8Pxjvp9OUlS+TKXPfE=;
        b=YVxbv7u0puycMczkBUtzZFqvhBNFQHFrO42dVOtbIPEj1tM5lVp3YLnWIK/7VJgm7N
         UyPtn59bLJoRDvrTB1H0y3wkw0+MKCOKbrJRyZW3gyHcKnsaSKT82qCXnkTcalR3JAh4
         r9qD8OQODdeOc/CHLbe0I+BSf4dugVuyT+LLfOF44sEkbZE9ASLX3SD4OvKudnP5MIGu
         TSdlB6cvgSIKAXXy6BHKehmoZuKamNNwp41z6fqoBf9gTxJKtJXQNcCQmN4xWPcSqXhE
         ggdT4gJ10Tf8UlrPNEPXBpMTQc4sO2K4VJ9asvo/dP3XDFtLasMtCZwKGDsQaQeBFaeI
         1GrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779609048; x=1780213848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=maSMJVpii3oREslg/+EI6BZ8V8Pxjvp9OUlS+TKXPfE=;
        b=l8H9wURMAHQ9pIU1x9vOw6a39Bd7GArgIGRSs0DLyYSB5SjdDXYTlC+dEcZH9ZEO5V
         idZrkaF8mXPmipYjW6mIcvdi1FW4Tu679eOtHnMJeDug3220Mfwy9gVFtSK8qKYB7YPl
         CAtP2UKavBJ+wzqKcauOV7rM0H2YVi5S7aJMjqodcp8v+DRV87mwalgrAx3Rx0afLOpv
         FccNZcGTLPwiduIjJQ8mjjWH3DIMLYQ99sgadl7NfOpMS+cpEh3xGSOzv1iINiI7WYj7
         2WSaV4oFNGBcJk/zsJs/YL2foziqYkTFidWK9O7jBPdfJcRN3CM0EOFu7g6LwMeS0NL/
         7xOA==
X-Forwarded-Encrypted: i=1; AFNElJ8TBELrKW0p3m0kxOF8qD6rVkJyJEaFi1hgohtCOFXS+gVCCIsKWfdkxT3QqEAms6OYtkp15Ug=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRIVJd12P/JfiwjFjy8eWPN9O/lckqDPLPARJ3yHuasRfQabuo
	tvJcOtW3e8N2g58gxgGbB9hlOns9xChlFAdZRSM5oWz/OYeeXiYMa/lR/Cqyt5ou8C2aaGu0B+6
	FN1RhTPzCSNGGIommBqPeL+lLU2YAubYNGOhusYws
X-Gm-Gg: Acq92OGYbkNSbjZiizVNNlo+efK1mLM5UoveiuivU8eqqw7+7K3E0VsND8fiGlBn8Bi
	SbBJc03ljbbJbGNkW6TioXRIsmceY3ms1hHh8YOUPPmGjUynWOHBz6jJIZmjyyw9V4PnSWUe4/0
	12QOrU/5jhSG94xnpmnd3bLPw9MO/wOOZr+GspdC3OBRme/3k33mm4GgZdJQuXPY7JwFqMIcv/y
	vRYF/Oo2FwF/9EtaymWpEqNN/irzUkd5suvPkUcLz+I1XZyxlNvqts98Clgq+bTDOlpSndGCSwx
	LVvlzLu/nVpj1MPiZ09qzSkGkHJmrH+XSSXj6i0ZfWLTyR+VM8pW24FapvINRZj74TKXNz1TAs/
	/BUFEHJ2mD6eOLWXTOtbuZUJeBIyk+EZRvycuKFwOcYmNsGtUkudYa5gIyHTd7S8=
X-Received: by 2002:a05:701b:2411:b0:12a:6c4b:9cf0 with SMTP id
 a92af1059eb24-1365f70f902mr2159515c88.3.1779609047214; Sun, 24 May 2026
 00:50:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523061654.2767060-1-kuniyu@google.com> <20260523061654.2767060-2-kuniyu@google.com>
In-Reply-To: <20260523061654.2767060-2-kuniyu@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sun, 24 May 2026 00:50:35 -0700
X-Gm-Features: AVHnY4ILlTc6CZGrBm2X4NNtAHXrbKQ4hUldshygCdQY2o5KxjGQgKzOBN5B4k0
Message-ID: <CAAVpQUAw-JYXZiW0k1mkZcvL9WH9JCVBoMyQAS2YGNOnDcCzuw@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 1/5] geneve: Reuse ipv6_addr_type() result in geneve_nl2info().
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Stephen Hemminger <stephen@networkplumber.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,networkplumber.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-291154-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 73FF35C1A44
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 11:16=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
>
> geneve_nl2info() calls ipv6_addr_type() to check if the remote
> IPv6 address is link-local.
>
> Then, it also calls ipv6_addr_is_multicast() for the same address.
>
> Let's not call ipv6_addr_is_multicast() and reuse ipv6_addr_type().
>
> Note that addr_type will be reused in the next patch, thus it is
> not defined inside the if-block.

I'll move addr_type to the if-block to avoid the unused var warning
for CONFIG_IPV6=3Dn.

pw-bot: cr


>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  drivers/net/geneve.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
> index e8ff03ed87dc..16b5f9e13859 100644
> --- a/drivers/net/geneve.c
> +++ b/drivers/net/geneve.c
> @@ -1898,6 +1898,7 @@ static int geneve_nl2info(struct nlattr *tb[], stru=
ct nlattr *data[],
>                           struct geneve_config *cfg, bool changelink)
>  {
>         struct ip_tunnel_info *info =3D &cfg->info;
> +       int addr_type;
>         int attrtype;
>
>         if (data[IFLA_GENEVE_REMOTE] && data[IFLA_GENEVE_REMOTE6]) {
> @@ -1933,13 +1934,13 @@ static int geneve_nl2info(struct nlattr *tb[], st=
ruct nlattr *data[],
>                 info->key.u.ipv6.dst =3D
>                         nla_get_in6_addr(data[IFLA_GENEVE_REMOTE6]);
>
> -               if (ipv6_addr_type(&info->key.u.ipv6.dst) &
> -                   IPV6_ADDR_LINKLOCAL) {
> +               addr_type =3D ipv6_addr_type(&info->key.u.ipv6.dst);
> +               if (addr_type & IPV6_ADDR_LINKLOCAL) {
>                         NL_SET_ERR_MSG_ATTR(extack, data[IFLA_GENEVE_REMO=
TE6],
>                                             "Remote IPv6 address cannot b=
e link-local");
>                         return -EINVAL;
>                 }
> -               if (ipv6_addr_is_multicast(&info->key.u.ipv6.dst)) {
> +               if (addr_type & IPV6_ADDR_MULTICAST) {
>                         NL_SET_ERR_MSG_ATTR(extack, data[IFLA_GENEVE_REMO=
TE6],
>                                             "Remote IPv6 address cannot b=
e Multicast");
>                         return -EINVAL;
> --
> 2.54.0.746.g67dd491aae-goog
>


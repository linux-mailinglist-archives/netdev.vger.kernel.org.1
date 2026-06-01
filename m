Return-Path: <netdev+bounces-293603-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WN7mMkg/HWq8XgkAu9opvQ
	(envelope-from <netdev+bounces-293603-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 10:14:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E151C61B4EB
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 10:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82827304B299
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 08:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D081A389116;
	Mon,  1 Jun 2026 08:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dk1fAHLC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6934A38737E
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 08:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780301217; cv=pass; b=ozdYhD2lEaovMepn/HD12+DbzumWStVhmfJAhDXeTJBjKmLVvmhFmjQ9outXRNIvKJ/7olUbOrrVoMzCCnFMiuPySiALJT9fcQm93aL2GTDj/ztJpa+G3FQLwYYEb/KMBjdok7geZNVlL0NXEVfd4ZZVR/nw5Oarw9WpyPELxGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780301217; c=relaxed/simple;
	bh=PfgwU3TC6U1vQQHO6cvoi8/yx6Vw4pGsuUreC49QqdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jGeNlRykgpaV+sXsZznnk51uP4+tpg7Z7IRHfSO49H1ywSCQf1Sikro7B338nf1AKuqZlt+I3FAsyQc9ofDjkfc2K0hVLUcKRjZw4ttb7gFMT3AQmArMPY+f3s33B8HTPcmC8URkSunN7Tic3KQhMGk/CMul9ecATYf+2LeONtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dk1fAHLC; arc=pass smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8ce9df49c5fso18288026d6.1
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 01:06:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780301214; cv=none;
        d=google.com; s=arc-20240605;
        b=Iq3kuHEyYHPAfA8QoDmNtxsfUnulpeIhBQBClsXNrMT9Woc/YQB29X1jNLxwVpu+9y
         yTlGFc5hvD+COeCm9YKA1VkZr2UPEVe2rH4/b7VKb6XdNGU202vXErkCEWMGI2euoU/0
         4gXHAQ1SxLTKoqHncWkg+SntzWNUlXwM2FejwBB6PR18O5NfMFD6ttSbQBqABVmU2E0/
         r0K+ZXhhn/VberHpHfVJ5a2b4gvOEEimHtg+44mxJS3Rhp8kWut0quFqVjugGc0ptFRq
         9K9HA540LAGtE1pPqTW/Ij78ax/CBQ0L5QIgtPCPMwnLKdis8Oz0wuJoYgNHIxH3N0AF
         ARRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d16XbiNDChip5TBKap+Bo8Ap1vi8uZrwZtEAazoL2FQ=;
        fh=9fMmGZ6K5YlQQ30QsfUd7AYO5UzLNlE5fD69bdoST6U=;
        b=cJvsc6Bwk2tyU03lWWmqxCydlUO9H2LmQHzyj0aIEk2F8nwr0RSJNvH/k+dl+FXZxD
         UGUfwN7AimVzV/WyQ76tpI2j2Wsd6P0ZsxJFwHtU1gh64sQMm8mdIXb6jePdI5OZ8y8b
         YVknc0Cidg0UZMS8gPtJFkoh5Oqz7V3XaWWWlpyl631uaTQruNXuBRAApLGhEt0EoCCE
         6E9d+pY8f0K8sGjHvp22rYUNvGJZDJ6Q53V1gOLyNEPmrpToZtP1mJWvEWMDlMryOcK+
         5whlu83tcScS7MMIALWSg1Mr2+6GTLEyQMNetmWGqR+JrKGN13LI3cy6Qg/ED5OjHsn1
         +Ccw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780301214; x=1780906014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d16XbiNDChip5TBKap+Bo8Ap1vi8uZrwZtEAazoL2FQ=;
        b=dk1fAHLCsF/kAIVZk/JLDe4v8bZVA0KTqPwhRtYZNVLDuDTcYj0EkxM2Vp5m3XDBGK
         AFLltARRRD/mWt1V9EfyZPA721qbLCmcPtEWBP0gPzOYtV0nnPyWah2YMCe5QtV9dQNY
         5rtJujPzO+fmxI0ZAUjqTpJrlfiP5t8/n8dUpO8YOmxUxQtwbhYv0eNHciHXOi29C6gi
         bW3k+ZGEnPGGtVzbNRlLMR0Rd2meRls7O+s1HqhJAPf1HnFo0BqnoxxI8Oa0BNvoZolY
         b+ZKzNkLh/jB2V1XpwLDUjlBCYnW0SDVa/J0VJEbVGxAwSt+xF400SDYZc0KZl46WJIw
         GKJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780301214; x=1780906014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d16XbiNDChip5TBKap+Bo8Ap1vi8uZrwZtEAazoL2FQ=;
        b=gLCv6dmvi+Qu+orO90pyg7dpCe6DElzSDid9vjxM76x5rFe7ubrygcuqpv6FjPZKpZ
         VafUHfz23uTCJ2jRteKzWcrO4eiUmpFEb6aROUkAsmtcU5DZz/5k7thDY4ifIij0sP5c
         HilaCdFNF6iC68o1ljgMpK5tOSdat1OvhbNuJkVyxOHRovdfQABlnfGUnldD1pbX/JSc
         w84w6WCoP6xjJqzdBN7b+XsNqiDvSmzCJ+qTBfgiDvr/mzIDkZDSkWCSjKvTkgHWmhne
         1qDBxSQKkb4pG6icd3eQvk5oniQl4tC4xvwRx/Dtf5vSIg4/7eUUsJuGamprFP1F4rL+
         UeUg==
X-Forwarded-Encrypted: i=1; AFNElJ8+UxowzkliSTf6slHaR3yzO1Xf9xVsC+zvkheifO6EIV9RA0S/RUSuAB7x8DN/dSkloCRUD64=@vger.kernel.org
X-Gm-Message-State: AOJu0YyucIKExh+e6epnYS0S3Mhcvg8SDBRAJZAdZLd+XleecNfI1NBR
	+O+VrFXF4sJ/EMl6gQWTZAmgkPbnJ3+npz8+/KWRujLsm4f0aI4nEkJqhhdaOudvp8J58C3MhCi
	zDLZmqDJdHjK9wWpU9Twb2nlUZzmH23jJq0jV71U8
X-Gm-Gg: Acq92OF6hkO+9WDhlu9ob9tQ5ER+mwcEUKH4SLLqnkZuNBLig8c9fvJD/VngHxGw+AH
	25GWQl4QGzQU6sowTpmvkdq2FDoxbY5CFyXHDXjMs0oSfYcUqBhxIu5CPekrbzKPSaa2NQxLXrJ
	CFkpMuyQVFJ+1VP/hHklorb3eMGMH/IxHlxagdnpGMpnI/GrpJ/yQb0hqrZjXzJSvmTuEvUHNoB
	9mrWE2VFlj+7exo41KeYiSSzIHkJVOyDU/Hg0W+Tz4ZvqUqvWrlpB//JOpKVZDOj3l5HGys+iSx
	OmvypxeWGyv4aRaZJFpy3+SWHTSpJ4w8OnmI/wnxXtj+WQuSrtuGU6Q7h/kTPUbvr49moP/6sW4
	bc6ZzMtcqGopFgF7v1MzaeEmfalEP
X-Received: by 2002:a05:622a:1e99:b0:516:e5ee:e07a with SMTP id
 d75a77b69052e-5173a729220mr153598981cf.16.1780301213831; Mon, 01 Jun 2026
 01:06:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601074201.1186061-1-runyu.xiao@seu.edu.cn>
In-Reply-To: <20260601074201.1186061-1-runyu.xiao@seu.edu.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 1 Jun 2026 01:06:42 -0700
X-Gm-Features: AVHnY4L8sfy7xeKdguxQm35oA8SDmMVTKnsMNvVA2rT-FUBWr-buC0Or4pEwjPA
Message-ID: <CANn89iLejarHYp92Uouu8nLErireX3JZe0YUbHBndDZOkhC03w@mail.gmail.com>
Subject: Re: [PATCH net] raw: annotate data-races in raw_v6_match()
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, linux-kernel@vger.kernel.org, 
	jianhao.xu@seu.edu.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293603-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[seu.edu.cn:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: E151C61B4EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jun 1, 2026 at 12:42=E2=80=AFAM Runyu Xiao <runyu.xiao@seu.edu.cn> =
wrote:
>
> raw_v6_match() is a lockless match helper under sk_for_each_rcu()
> and still reads inet_sk(sk)->inet_num, sk->sk_bound_dev_if,
> sk->sk_v6_daddr and sk->sk_v6_rcv_saddr with plain loads.
>
> Add READ_ONCE() annotations for these fields.
>
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
>  net/ipv6/raw.c | 29 +++++++++++++++++++++++------
>  1 file changed, 23 insertions(+), 6 deletions(-)
>
> diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
> index 3cc58698cbbd..7160d5513742 100644
> --- a/net/ipv6/raw.c
> +++ b/net/ipv6/raw.c
> @@ -64,20 +64,37 @@
>  struct raw_hashinfo raw_v6_hashinfo;
>  EXPORT_SYMBOL_GPL(raw_v6_hashinfo);
>
> +static void raw_v6_addr_snapshot(struct in6_addr *dst,
> +                                const struct in6_addr *src)
> +{
> +       dst->s6_addr32[0] =3D READ_ONCE(src->s6_addr32[0]);
> +       dst->s6_addr32[1] =3D READ_ONCE(src->s6_addr32[1]);
> +       dst->s6_addr32[2] =3D READ_ONCE(src->s6_addr32[2]);
> +       dst->s6_addr32[3] =3D READ_ONCE(src->s6_addr32[3]);
> +}

I do not think we want to incur an extra cost for such a minor race.

Note that your patch does not solve the race, since writers do not
update these fields atomically anyway.


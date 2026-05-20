Return-Path: <netdev+bounces-289731-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDQxGX4nDWo8twUAu9opvQ
	(envelope-from <netdev+bounces-289731-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 05:16:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B36405871EF
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 05:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B186303DD71
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 03:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03D43314C4;
	Wed, 20 May 2026 03:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGJZR5/W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C14830DED0
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 03:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779246613; cv=pass; b=HUXOARA/Ce1h3vBoJFLhE0mvWU7Z5qyFeK1eJUAaWSZvEaQ+TjjTgBfTYKsihcT6RieTRiKhrpyB+0nTno5WFsryUbucNoLRxNzIdt3Ea+aoZRpjpO5kR+d0ZqL1Ff8oc/q0p2PErMC8++7OwtsNfEOfEJbxiqZAD2fX7Nzf/g8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779246613; c=relaxed/simple;
	bh=lfSdNjWMtkG8VkXNL0EEO+awV6SktNMYQIryB280qiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yd8jcyGQvJAC+aX6BaWZjiU7Z36jBjN/oLsasFcKvf32yCzaesDnGVBeosNJPr3LisPK+pdwQ4p8v3iBEHkVkRcP9f4PnhqCmv7wG8gUoZgajxu/EsAvMO1ArGzLFAlpzZVLLIfaaw8CKHGZHa2LcKTYtWn4+gg/1fgOFHg4/e4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGJZR5/W; arc=pass smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6948ed7139eso2024634eaf.0
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 20:10:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779246611; cv=none;
        d=google.com; s=arc-20240605;
        b=DEPco9Jfvku7IR0IBGCdl0AUNbErr24/Yx0L77pCINzQMksDVSUkmn1vGt7fn07lB3
         JGXD9Ef8IXG+6D5zG5cFz7FqMpjHpAP7vpf6TNjluvKuKq1pVkWtCdumxZma+zbwuT9v
         47Dhoxy0tdgfCziCE7SZWfy20pjxHTUl47NMdO93bzYQBMVsGDv6L3co2J/GZpQV7kqh
         i/pCHKC5YO9QohBJOP7GYBYoZVtmJTAlpPD6ukM/A7GErPlGmLkcRH2Qqzv6XFC604iI
         yS3x/KRoxE8tdKw9eiTD8xy/AwSOTcIhCf9Ewz3EvrQa7RTn2uenEVgUPmj1+20+waNv
         8TQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KWn1xNaNd0DfVADboGKTeHJq6jNFRmqTRtIeylkf/Yo=;
        fh=qQuXDHegpil+b/fBTjNYJaoOgsw8aL9IanQ4rTrUJOA=;
        b=ftFXtHrK55VW8SMMtAfmZe44glwXnlgGmnDn3Ne8+jpuwiOm/Yeic1WJQjcHHHL6NM
         PrgIa4T8tRsgkG4Qt6IzkqxNTF7bmpqPnBKiHbtHxQCZKDQ6kifETb30caPX4NgW2MEm
         GX62xatmwU1V4kmV+u5OsQ8fKQtaZEpE5y1fM8nNvsqEvhjjnd5UF/tbWvM4AxKRUDcb
         M3AQGEZOJtMzJAbZ/x+YBIe63R6e8KJwHmj8cG8Nx4N4d6RQmNkRl8K+Sma8P50Fp/eN
         kOd/i9ffNXbYzstYpTmY0FuHQHVgCgQAMN1mDAMP8/kdaPgOFecYGzFLHHtBQSZhDIEw
         z6Og==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779246611; x=1779851411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWn1xNaNd0DfVADboGKTeHJq6jNFRmqTRtIeylkf/Yo=;
        b=YGJZR5/Wj+YNa8EamuAiJhwvMBsUonP8lRuqRnP7zOBAZZuzNwYuxF9jfiqsvPDSHv
         UQGOfcnhN6crXUeYXk9hmfQYlFYhjSEj3Z9a8YzZEFPjXaONTE4Rhw7Nf9Zq8kLnzfFJ
         Q0h7nQ/PXIc7H+i7qm+QnBVJ8vxtI0Rg7Zp6xSX9LpwFNuEWrf4teBwvRat8zuxXv3Yu
         0qbCxkqC9Rt7B21IRXCt6mWWCDNkxSmgaEnVLstbaQXpMyoKY9bqGJZMRIA1K3Sl2/Rk
         m96RU4XxQtchDnwG+41tJI5fPaA+hZimbhC95CWHriIwu0DGKmXE/IqA1AVjyBcrBhYP
         KIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779246611; x=1779851411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KWn1xNaNd0DfVADboGKTeHJq6jNFRmqTRtIeylkf/Yo=;
        b=kZNDc4AZg8bJOKp75Wk7cImV9TkajW+FAfDvlhRwMr8B0THOwWVE6JgxOUrTF9biga
         Zv34Xh6fLc1yB6xIDtuqCrKMnL7e/DoDRuD/wGR/PJRyt+DdI5a8NItCmNHfZZiqp+yi
         yyuPrmY5k4hFIwZwqWS5M43e7r7W+KV/bBCPagLzLqGQ9/Vx61AWO4qVN3n4FukWqebj
         L2mntzu0hEk5GnZxGq5eXA+4T5pKQcC4YmYk0TezcmYcWRZ+muHraeQ96yBlKkCI+eWX
         UoWLVzixp7eBEWa7dFN7ICvH0N5RmOt2hmWXmGCrZnDxe1eL+txXsj/fS6MACnvowC9S
         uBtA==
X-Forwarded-Encrypted: i=1; AFNElJ834wwWuSzNvZGrV/YjDjKsbzvky3o73LCDZBqUqEXMKohGtw2L0xC+SHeKo9KDCKHkZ+tkPQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzRB9DRjRvxn7qA2A2ZasecQF/x5IiLlKLXJlFagqMPGuojBlk
	tsaCH3JEqEcoQF8Sb/fw5MIW9Bs4ETtfIQTuBJmfwP7n5sYR7bIyynGHE76oXVL6on8z4/s8pwV
	y8PkgFa5cnRHqX1HDXkdYFNHsn+k8tFA=
X-Gm-Gg: Acq92OFf9kVcxqpMswl/GgppvTgFa3jMYCatuedVvHAUlGzi3B8c1M5r3VJZH7Wau3f
	Db8K/s+zmNIT/FAwaTNaM6eZI54e7qyCPtMKIJq19T4DMgcol6IczNWrNU8zWM6u+BKgvvyF2Pb
	c7JpOeFqmT2gIzgtZtHqUf4LQMk6oo1PIf6TaV+/Lx3peHYPn86vbp0KtcVt8Ev04uOljoHsCcE
	CJi2KMP9vWPIV4YCo4EW5UucOichIm5nw9piZGq8TEHnwLNb+wBkLTdfaqQa8Y2zRMjeiNdYaJC
	XsQ+xoeLyjpJo9QBZuw7Ug4+4DC0EOrB54qSwo0=
X-Received: by 2002:a05:6820:4cc2:b0:69b:73d8:60ba with SMTP id
 006d021491bc7-69c942e0844mr15543273eaf.21.1779246611269; Tue, 19 May 2026
 20:10:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520022242.120640-1-mmyangfl@gmail.com> <20260520030803.1615-1-qingfang.deng@linux.dev>
In-Reply-To: <20260520030803.1615-1-qingfang.deng@linux.dev>
From: David Yang <mmyangfl@gmail.com>
Date: Wed, 20 May 2026 11:09:35 +0800
X-Gm-Features: AVHnY4KXJaCfbJqTudMWxlH89HaJ5Mteo3loISDQb8wtiR1LNd6sWqGh_Erz9fs
Message-ID: <CAAXyoMPTnRLeHL=Dk96MRg2n6B7js4EuPeRGvZRU=z9O0bxFWA@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: dsa: yt921x: Add ACL support
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: hong son Nguyen <hongson.hn@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289731-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: B36405871EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 11:08=E2=80=AFAM Qingfang Deng <qingfang.deng@linux=
.dev> wrote:
>
> On Wed, 20 May 2026 at 10:22:36 +0800, David Yang wrote:
> > Enable filtering of incoming traffics. Note that custom filters are yet
> > to be utilized, and thus not all flow dissectors are implemented.
> >
> > Tested-by: hong son Nguyen <hongson.hn@gmail.com>
> > Signed-off-by: David Yang <mmyangfl@gmail.com>
> > ---
> > v1: https://lore.kernel.org/r/20260514192140.3468543-1-mmyangfl@gmail.c=
om
> >   - fix issue reported by test robot
>
> The always-false comparison is still there:
>
> > +             if (match.mask->ip_proto) {
> > +                     enum yt921x_l4_type type =3D YT921X_L4_TYPE_OTHER=
;
> > +
> > +                     if (match.mask->ip_proto =3D=3D ~0)
>
> ../drivers/net/dsa/yt921x.c:1821:29: warning: result of comparison of con=
stant -1 with expression of type 'u8' (aka 'unsigned char') is always false=
 [-Wtautological-constant-out-of-range-compare]
>  1821 |                         if (match.mask->ip_proto =3D=3D ~0)
>       |                             ~~~~~~~~~~~~~~~~~~~~ ^  ~~
> 1 warning generated.
>
> > +                             switch (match.key->ip_proto) {
> > +                             case IPPROTO_TCP:
> > +                                     type =3D YT921X_L4_TYPE_TCP;

Sorry, v1 was sent by mistake. Please ignore this version.


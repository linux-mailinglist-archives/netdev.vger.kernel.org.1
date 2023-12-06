Return-Path: <netdev+bounces-54526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2058807622
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 18:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83BF9280CE9
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 17:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F45B47783;
	Wed,  6 Dec 2023 17:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wtq4KGSP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF358D68
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 09:10:38 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso12215a12.1
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 09:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701882637; x=1702487437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lwipZRYP68MwvGKpxe2nbmlgkEPACW9Z23S8fB6dauk=;
        b=Wtq4KGSPobe/QBsUlbTQDZLnitr4xMQNThiqzcKnZFQyY0/3qk4LBm8ZVnyCiGplxf
         KuYpwPgCeuqLKBU326rhBdq9AoqZnepAO9ULaPiQYUH7WNWE045oZF6Xs0UmkkDOfrm8
         FY1EQmePXIprWDIbK+11hATz+tKUAJl7vEh9tXo6PhE7N48F4oVxLTKjNdn9F0/6GA0H
         RU2fEHAxUiVOpuELgi+Aw76xNwTP9lMa65ZlNIiN2qxwIwhLnSjdGOP+4Xt5K7oF7Scs
         umulVEhR/IPTgatK5MBak/MB1PrK0onLR9eHibcgQN0IBMxCwKrr8AdScblEUSHTFSL6
         01tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701882637; x=1702487437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lwipZRYP68MwvGKpxe2nbmlgkEPACW9Z23S8fB6dauk=;
        b=HienYER7kmnZg5el/B5PRcVfS98I5rBFp4/bYjdFOR7+zyCBlvFf4rM+X2R7e0MBX7
         t7oHvPCpjSZe0YIYt3vMeJm010Snpa4B2UD0nT0lo0qOLz79I6MrNFlYEaH7jt/oL1bi
         ryV+g7bf7Sjt5f5Ps+8NLIfD2wANyGy2b+sxHIcYTrLO/MA6Pbc/LrrYi4RHNuh2jJRj
         kXxTAT9GH9xovPkyTHxaqNqns2WUad0BLA69cTzOZxiXh+/LFZrSwYIQP+Kp+pqnBAAf
         MH77HG6kP8W4KfIlghV+qEfEdmEAkho4nICA127AvXK/QRBAiASwGymaTlo07bStDYug
         PtPw==
X-Gm-Message-State: AOJu0YyZAxsHkU4MxUyA1itjGQ91biEuLL0ftw4Q0hwUjwZbpMREr4TG
	JdPL4OhRhK9LyvYS/SyMuBokLZHPbtsKZXzvIgf2cw==
X-Google-Smtp-Source: AGHT+IG8w7aeFmIObymec4lXdg3a0PvMYuIPdRSccLDvqXdWX+88dc5FjbcqxHAfMlJxZg4XG0nWzs2uagote1WlA8Q=
X-Received: by 2002:a50:c35d:0:b0:54a:ee8b:7a8c with SMTP id
 q29-20020a50c35d000000b0054aee8b7a8cmr121110edb.0.1701882636993; Wed, 06 Dec
 2023 09:10:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206141054.41736-1-maze@google.com> <CANn89iKwwfUzh23+dwS5iUCy1vybQ17TqNFbuKc_D2V-RD-i4g@mail.gmail.com>
 <CANP3RGewCVT8fATuL3tfVAkE-zgZQpJhNSKJJp6Rc37+2fTofA@mail.gmail.com>
In-Reply-To: <CANP3RGewCVT8fATuL3tfVAkE-zgZQpJhNSKJJp6Rc37+2fTofA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 6 Dec 2023 18:10:22 +0100
Message-ID: <CANn89iLfhRXCZD3KpYf9SDjwu8Sj3RKgKHYGmO44=vrxCH1DAQ@mail.gmail.com>
Subject: Re: [PATCH net v2] net: ipv6: support reporting otherwise unknown
 prefix flags in RTM_NEWPREFIX
To: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shirley Ma <mashirle@us.ibm.com>, 
	David Ahern <dsahern@kernel.org>, Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 6:03=E2=80=AFPM Maciej =C5=BBenczykowski <maze@googl=
e.com> wrote:
>

> On patchworks I also see a complaint about the Fixes tag referencing a
> non-existing commit:
>
> Commit: d993c6f5d7e7 ("net: ipv6: support reporting otherwise unknown
> prefix flags in RTM_NEWPREFIX")
> Fixes tag: Fixes: 60872d54d963 ("[IPV6]: Add notification for
> MIB:ipv6Prefix events.")
> Has these problem(s):
> - Target SHA1 does not exist
>
> I (automatically) pulled it (via git blame) from tglx-history @
> https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
> graft...
> $ git log --oneline -n1
> remotes/tglx-history/v2.6.2..60872d54d963eefeb302ebeae15204e4be229c2b
>
> I'm not sure... would it be better to just not include a fixes tag at
> all and just CC stable@?

Simply use the generic

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")


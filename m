Return-Path: <netdev+bounces-49098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE7E7F0D10
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 08:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76B651F21745
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 07:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302AC748E;
	Mon, 20 Nov 2023 07:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z4y9ObKe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530EFB9
	for <netdev@vger.kernel.org>; Sun, 19 Nov 2023 23:56:17 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40837124e1cso73905e9.0
        for <netdev@vger.kernel.org>; Sun, 19 Nov 2023 23:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700466976; x=1701071776; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/WDzDyOeR2q+ieJPiPlsSR1q0vBPVX0Mwy7l1gcnUDI=;
        b=z4y9ObKecFSCNiWNitum08PqbTS0hhVznr2ehOIwuPIIpeytk/aJKO+/qIPCyR98C/
         Fi0okbCfrgTvkZxfvyhyljfRLWeqS0mIhI1TO6gfJiHE3VnhSZ24WiCYfcfoAKiLglPp
         DrmNaGPpJstwQO5Ggk+ERQLLgvCPs3WOuEbXbUMllXbqh1+ll3jlCo6et2f1JU7456Vb
         jpnBuq6g3d1jJiiyQfA+l3AZhy1m3QFhMwg6JbFaE5pTJfbAqZdlMx7TlB/4tjCjKrh+
         7yrC52dVXsa30NyPqNY8b/QDz2CiNzna4CDN7W/ydMCpzqrWL/kwTZ1OxgHZBXnfgOU4
         obJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700466976; x=1701071776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/WDzDyOeR2q+ieJPiPlsSR1q0vBPVX0Mwy7l1gcnUDI=;
        b=tTDuTqAmtWsJZpcjYtmLJQGitfwtQ8ySe0CaH2YkB/NXw6HtTC72YHRcr6eaPRbCrF
         Mfpdtms5HjeQ8YonqtTE0qSLVVez3XVF4UdVfZA+GAI0bdg2TIeL0RVGVT6HckeATKQ5
         2M2WOOhBbtOFnOh0xMFYqmyyGgiCaYawb0M3kk7CoQ71yT0Cjk72cFV/WQh6eVBV8C0p
         +KLXZJtGUZJJOnsbOtUot+yUNa1+ti28RLjVB8vHSTJrd4fgFRpQ9QnZj136yh10SOHN
         6x9+dwCgfJAV5AXTlF1Piz5cr7m4dUymk8Zojbv0wRwJNEyirw0k0y6a8+dikkWzJvim
         ojCw==
X-Gm-Message-State: AOJu0YxP/HxJWAbdN7jod84FNji70OYqY8VJ7A+879Xc5p1+WCDCGaLt
	YabDQ7vhWCsumq+1FtkSYhKMJ+hhJC228n4J945fjw==
X-Google-Smtp-Source: AGHT+IHHbHJiqMO5fYscAMk3rH3FLcDcq3mKCRGLE/nHP6xvTxkWkkvZkjmJuAxcZ68GFxtJJK7WuLnKi1iKzrMpwo8=
X-Received: by 2002:a05:600c:1c13:b0:408:3e63:f457 with SMTP id
 j19-20020a05600c1c1300b004083e63f457mr184981wms.2.1700466975445; Sun, 19 Nov
 2023 23:56:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231117141733.3344158-1-edumazet@google.com> <170042342319.11006.13933415217196728575.git-patchwork-notify@kernel.org>
 <CAHmME9q4uSKxtEnRmcM2h2GGSBcq9Hu_9tk3EX2_EVGFXr6KnQ@mail.gmail.com>
In-Reply-To: <CAHmME9q4uSKxtEnRmcM2h2GGSBcq9Hu_9tk3EX2_EVGFXr6KnQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 20 Nov 2023 08:56:02 +0100
Message-ID: <CANn89iLm0SX4dF1Y29ui=SxO5ut=v66S6SvgFsD2cjU=JN1pmA@mail.gmail.com>
Subject: Re: [PATCH v2 net] wireguard: use DEV_STATS_INC()
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: patchwork-bot+netdevbpf@kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzkaller@googlegroups.com, liuhangbin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 1:11=E2=80=AFAM Jason A. Donenfeld <Jason@zx2c4.com=
> wrote:
>
> Hi,
>
> On Sun, Nov 19, 2023 at 8:50=E2=80=AFPM <patchwork-bot+netdevbpf@kernel.o=
rg> wrote:
> >
> > Hello:
> >
> > This patch was applied to netdev/net.git (main)
> > by David S. Miller <davem@davemloft.net>:
> >
> > On Fri, 17 Nov 2023 14:17:33 +0000 you wrote:
> > > wg_xmit() can be called concurrently, KCSAN reported [1]
> > > some device stats updates can be lost.
> > >
> > > Use DEV_STATS_INC() for this unlikely case.
> > >
> > > [1]
> > > BUG: KCSAN: data-race in wg_xmit / wg_xmit
> > >
> > > [...]
> >
> > Here is the summary with links:
> >   - [v2,net] wireguard: use DEV_STATS_INC()
> >     https://git.kernel.org/netdev/net/c/93da8d75a665
> >
> > You are awesome, thank you!
>
> I thought that, given my concerns, if this was to be committed, at
> least Eric (or you?) would expand on the rationale in the context of
> my concerns while (or before) doing so, rather than just applying this
> without further discussion. As I mentioned, this is fine with me if
> you feel strongly about it, but I would appreciate some expanded
> explanation, just for my own understanding of the matter.
>
> Jason

Jason, I was in week end mode, so could not reply to your message.

This fix is rather obvious to me. I do not want to spend too much time on i=
t,
and you gave an ACK if I am not mistaken.

If you prefer not letting syzbot find other bugs in wireguard (because
hitting this issue first),
this is fine by me. We can ask syzbot team to not include wireguard in
their kernels.


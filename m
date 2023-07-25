Return-Path: <netdev+bounces-20798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EF1761061
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 12:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDD5E1C20D5B
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 10:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EA718AE8;
	Tue, 25 Jul 2023 10:15:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D9714A91
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 10:15:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93909C433CC;
	Tue, 25 Jul 2023 10:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690280125;
	bh=hk8s9U4aku/7NMyH7BUL+F1PpRRQQ59PN2hfITnjTVE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Uz9Uq3ekZhN/d14VXs/7apxFaWgqYSAciN9aaNWebnJzaQ/vv0RZx60oviF9aDFfO
	 FfxNlWWofAxBgmtJ2GqCG5bc/UCeU6cmwDqSG5gu+2xdAlW84SWC66T/9Ea2h7vDTl
	 zV+6GDjOMafbZ21OI8RWKkbr5LYCBY5ynlZ2aYCuG7bk1eyMFF+SLPiliYdhRRg0Ge
	 wk8fkI7FEn+Jnr81WjrdwGz6BOO+K7b5gdki13Wo6OnhE/7raVtR1MwjBHHew18MH7
	 /u6jmcyx6zKDeUvsfRwp1edvfq0rzT5JvREVEdHf3KS70mRH+LddTl//mrNuPJ390e
	 Y2mJ1cvaRRMpw==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-4fb41682472so8052178e87.2;
        Tue, 25 Jul 2023 03:15:25 -0700 (PDT)
X-Gm-Message-State: ABy/qLbioqWNxf3bZCu6oUgsYgmGW8DqjZMBYFRQVxo3IztU+axJBazO
	rqEj2dKX4Rk5HxboIjOu2ZBapw2RZU0b6ys/wDY=
X-Google-Smtp-Source: APBJJlFL5PlFPlTKZlnrORr+4EFa8QloNsr9WS714msWOKtWqsR7UdEi8SMfTyPM8k2z6Gm1c2rghgvQOYLYIbgqR7g=
X-Received: by 2002:a05:6512:2109:b0:4fc:ab2e:8751 with SMTP id
 q9-20020a056512210900b004fcab2e8751mr7113692lfr.1.1690280123489; Tue, 25 Jul
 2023 03:15:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230724090044.2668064-1-ilia.lin@kernel.org> <20230724181105.GD11388@unreal>
 <CA+5LGR3ifQbn4x9ncyjJLxsFU4NRs90rVcqECJ+-UC=pP35OjA@mail.gmail.com>
 <20230725051917.GH11388@unreal> <CA+5LGR2oDFEjJL5j715Pi9AtmJ7LXM82a63+rcyYow-E5trXtg@mail.gmail.com>
 <20230725093826.GO11388@unreal>
In-Reply-To: <20230725093826.GO11388@unreal>
From: Ilia Lin <ilia.lin@kernel.org>
Date: Tue, 25 Jul 2023 13:15:12 +0300
X-Gmail-Original-Message-ID: <CA+5LGR1K-=-c8_pjyPTbT9B=SinHv8f61jzeOnjRDODffrPbsQ@mail.gmail.com>
Message-ID: <CA+5LGR1K-=-c8_pjyPTbT9B=SinHv8f61jzeOnjRDODffrPbsQ@mail.gmail.com>
Subject: Re: [PATCH] xfrm: kconfig: Fix XFRM_OFFLOAD dependency on XFRM
To: Leon Romanovsky <leon@kernel.org>
Cc: Ilia Lin <ilia.lin@kernel.org>, steffen.klassert@secunet.com, 
	herbert@gondor.apana.org.au, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jeffrey.t.kirsher@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2023 at 12:38=E2=80=AFPM Leon Romanovsky <leon@kernel.org> =
wrote:
>
> On Tue, Jul 25, 2023 at 12:11:06PM +0300, Ilia Lin wrote:
> > On Tue, Jul 25, 2023 at 8:19=E2=80=AFAM Leon Romanovsky <leon@kernel.or=
g> wrote:
> > >
> > > On Tue, Jul 25, 2023 at 07:41:49AM +0300, Ilia Lin wrote:
> > > > Hi Leon,
> > >
> > > You was already asked do not top-post.
> > > https://lore.kernel.org/netdev/20230718105446.GD8808@unreal/
> > > Please stop it.
> > >
> > > >
> > > > This is exactly like I described:
> > > > * xfrm.h is included from the net/core/sock.c unconditionally.
> > > > * If CONFIG_XFRM_OFFLOAD is set, then the xfrm_dst_offload_ok() is
> > > > being compiled.
> > > > * If CONFIG_XFRM is not set, the struct dst_entry doesn't have the =
xfrm member.
> > > > * xfrm_dst_offload_ok() tries to access the dst->xfrm and that fail=
s to compile.
> > >
> > > I asked two questions. First one was "How did you set XFRM_OFFLOAD
> > > without XFRM?".
> > >
> > > Thanks
> > >
> > In driver Kconfig: "select XFRM_OFFLOAD"
>
> In driver Kconfig, one should use "depends on XFRM_OFFLOAD" and not "sele=
ct XFRM_OFFLOAD".
> Drivers shouldn't enable XFRM_OFFLOAD directly and all upstream users are=
 safe here.

Thank you for that information, but the XFRM_OFFLOAD doesn't depend on
XFRM either.

>
> Thanks


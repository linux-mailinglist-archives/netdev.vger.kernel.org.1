Return-Path: <netdev+bounces-20805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F09C7610D0
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 12:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 709A51C20CFE
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 10:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC831EA72;
	Tue, 25 Jul 2023 10:27:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3981F1ED32
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 10:27:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF1ACC433C7;
	Tue, 25 Jul 2023 10:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690280826;
	bh=dEUftBuVlThgLNzSUzD39UsyTnVeI1zwp2BGdviWBrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TEFDw1rUnewSFxDujnX4M1bWQ+pQFPlX+Lb7Ad/oSwZZUFC8Ddv/bwQU3FZjnj0/M
	 VH9ULWCbJYwG0CX7eBIPJnutCyK4L9qLtpDTVBkom9tefKT6WBiV8SiIR5397ehmsd
	 LQwFdgo2IsrCFeicn26DIUu5LnmlbXd4ZkxHyDdIbiz8rgrSEu5JGsjSbt38Zv2rYn
	 9iT74l3K4xfq+HPUGI85UImETX95HtkqrolHY9kOiw8c/X1CRkvBpbvV1w7KWW1EQz
	 tYanXCqFUPi9jChfp5dEd52cvuJV/3tbUk3iQusCjvqEZaBi/B1MAfnV2KU1xYqgDS
	 GReDuBZkhRi+w==
Date: Tue, 25 Jul 2023 13:27:02 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Ilia Lin <ilia.lin@kernel.org>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, jeffrey.t.kirsher@intel.com
Subject: Re: [PATCH] xfrm: kconfig: Fix XFRM_OFFLOAD dependency on XFRM
Message-ID: <20230725102702.GP11388@unreal>
References: <20230724090044.2668064-1-ilia.lin@kernel.org>
 <20230724181105.GD11388@unreal>
 <CA+5LGR3ifQbn4x9ncyjJLxsFU4NRs90rVcqECJ+-UC=pP35OjA@mail.gmail.com>
 <20230725051917.GH11388@unreal>
 <CA+5LGR2oDFEjJL5j715Pi9AtmJ7LXM82a63+rcyYow-E5trXtg@mail.gmail.com>
 <20230725093826.GO11388@unreal>
 <CA+5LGR1K-=-c8_pjyPTbT9B=SinHv8f61jzeOnjRDODffrPbsQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+5LGR1K-=-c8_pjyPTbT9B=SinHv8f61jzeOnjRDODffrPbsQ@mail.gmail.com>

On Tue, Jul 25, 2023 at 01:15:12PM +0300, Ilia Lin wrote:
> On Tue, Jul 25, 2023 at 12:38 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Tue, Jul 25, 2023 at 12:11:06PM +0300, Ilia Lin wrote:
> > > On Tue, Jul 25, 2023 at 8:19 AM Leon Romanovsky <leon@kernel.org> wrote:
> > > >
> > > > On Tue, Jul 25, 2023 at 07:41:49AM +0300, Ilia Lin wrote:
> > > > > Hi Leon,
> > > >
> > > > You was already asked do not top-post.
> > > > https://lore.kernel.org/netdev/20230718105446.GD8808@unreal/
> > > > Please stop it.
> > > >
> > > > >
> > > > > This is exactly like I described:
> > > > > * xfrm.h is included from the net/core/sock.c unconditionally.
> > > > > * If CONFIG_XFRM_OFFLOAD is set, then the xfrm_dst_offload_ok() is
> > > > > being compiled.
> > > > > * If CONFIG_XFRM is not set, the struct dst_entry doesn't have the xfrm member.
> > > > > * xfrm_dst_offload_ok() tries to access the dst->xfrm and that fails to compile.
> > > >
> > > > I asked two questions. First one was "How did you set XFRM_OFFLOAD
> > > > without XFRM?".
> > > >
> > > > Thanks
> > > >
> > > In driver Kconfig: "select XFRM_OFFLOAD"
> >
> > In driver Kconfig, one should use "depends on XFRM_OFFLOAD" and not "select XFRM_OFFLOAD".
> > Drivers shouldn't enable XFRM_OFFLOAD directly and all upstream users are safe here.
> 
> Thank you for that information, but the XFRM_OFFLOAD doesn't depend on
> XFRM either.

Indirectly, XFRM_OFFLOAD depends on XFRM.

INET_ESP_OFFLOAD -> INET_ESP/XFRM_OFFLOAD -> XFRM_ESP -> XFRM_ALGO -> XFRM.

Thanks

> 
> >
> > Thanks


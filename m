Return-Path: <netdev+bounces-21086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C30762569
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 00:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FC811C20FFD
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 22:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382ED27702;
	Tue, 25 Jul 2023 22:03:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D227226B6D
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 22:03:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3DD0C433C7;
	Tue, 25 Jul 2023 22:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690322595;
	bh=oQxFAhpidA9V2q1VPA63bxve/3DIExxQn19eeLCZFhc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Xfev1x+Y1clHe6sv0jKhTpqz1JV6DGoLLUWc+caEfWdYUvcPtw50VRYQwTM391dHI
	 Er5WuRP0GuFrUhnBALijqFaMVi7SUyWvBDaKwStDikU5/sc40/g1CWnaBLp63G17pg
	 RWgGvXMjHWh6QSEXMZP77oYoLHrWumFzyL6ytPkZFajxFcApanfJ8erIQNJiOES0wg
	 6fjxcp5PThRoUujauwI887hkfkWyloOD5tWtZu+8mg/vp+y+ZGVCqFPv3/ToNd/sTG
	 taMY2mV0g0gD4XesaEDic4oyu9pyrib3zQicPp4VtOAYJSkeYPd9khNYqPnLHxZlFC
	 WJKeRWS0Q8dLw==
Date: Tue, 25 Jul 2023 15:03:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: valis <sec@valis.email>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, pctammela@mojatatu.com,
 victor@mojatatu.com, ramdhan@starlabs.sg, billy@starlabs.sg, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH net 0/3] net/sched Bind logic fixes for cls_fw, cls_u32
 and cls_route
Message-ID: <20230725150314.342181ee@kernel.org>
In-Reply-To: <CAEBa_SASfBCb8TCS=qzNw90ZNE+wzADmY1_VtJiBnmixXgt6NQ@mail.gmail.com>
References: <20230721174856.3045-1-sec@valis.email>
	<8a707435884e18ccb92e1e91e474f7662d4f9365.camel@redhat.com>
	<CAEBa_SB6KCa787D3y4ozBczbHfZrsscBMmD9PS1RjcC=375jog@mail.gmail.com>
	<20230725130917.36658b63@kernel.org>
	<CAEBa_SASfBCb8TCS=qzNw90ZNE+wzADmY1_VtJiBnmixXgt6NQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 25 Jul 2023 23:36:14 +0200 valis wrote:
> On Tue, Jul 25, 2023 at 10:09=E2=80=AFPM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> > We don't know who you are. To my understanding the adjustment means
> > that you are not obligated to use the name on your birth certificate
> > but we need to know who you are. =20
>=20
> I could start a discussion about what makes a name valid, but I'm
> pretty sure netdev is not the right place for it.

Agreed, I CCed Greg KH to keep me honest, in case I'm outright
incorrect. If it's a gray zone kinda answer I'm guessing that
nobody here really wants to spend time discussing it.

> > Why is it always "security" people who try act like this is some make
> > believe metaverse. We're working on a real project with real licenses
> > and real legal implications.
> >
> > Your S-o-b is pretty much meaningless. If a "real" person can vouch for
> > who you are or put their own S-o-b on your code that's fine. =20
>=20
> I posted my patches to this mailing list per maintainer's request and
> according to the published rules of the patch submission process as I
> understood them.
> Sorry if I misinterpreted something and wasted anybody's time.
>=20
> I'm not going to resubmit the patches under a different name.
>=20
> Please feel free to use them if someone is willing to sign off on them.

If Jamal or anyone else feels like they can vouch for the provenance
of the code, I think that may be the best compromise.


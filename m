Return-Path: <netdev+bounces-117289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCD694D7B7
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 21:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 673181F21D63
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 19:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DD815FCE5;
	Fri,  9 Aug 2024 19:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Zf9yZZFl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFA122EE3;
	Fri,  9 Aug 2024 19:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723233294; cv=none; b=neCGf7CoNFQb0qHO3ModXEyKFxzsALFi/jAzBEpzRv6ybXZ7743mNWKE/MZEeZgBqm1vZ42lO9aRiNaNTA116DmPQE3/hhliSqsLczs8ZrUWavFl8Qp8aHuKc0hBRIwWBaB6U6BkOsI+MvbgmOrWvIjxqoG2qh6MeiATJfWiBik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723233294; c=relaxed/simple;
	bh=ceYFtbCt/wR6DHo/eTWxUYo/JKL1BhmNxnLXwd2akX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AjKKZJ0GwUSsQv63BI86QsjAIfT88t+IkdrdH/UheIZxPXCAf9gUyMaWTJRHbe50ncfrRCXEl/CzHcw9L1mKCntHFtPkGo6Ko4SgFHMQAIKA6JA8k5schwj+W9nQHin/R4PeWDeVfoxf3TOfPbd5EnYhxbXkamd/E3nJW5Z5PGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=Zf9yZZFl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDF5EC32782;
	Fri,  9 Aug 2024 19:54:52 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Zf9yZZFl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1723233291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3N3o+9M3H1vCcqO4cyPqj4mxZb4SylgWgLhSb7Wgy+Y=;
	b=Zf9yZZFlcooOshFExetWzVEsDVXxJRHEuzSQyjeXx4DwCKQFHcFIQODewaD/JGoOll++qS
	JObNLmOapd34N8EUThXutD3bUJOwcxOV7wSxHnhv33n/mJRT2+42PqIDpNFcPuFjlQMKpV
	qcgeInJTiLUmHi56EngQI00lYZ3OXYA=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 626280f1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Aug 2024 19:54:49 +0000 (UTC)
Date: Sat, 10 Aug 2024 04:54:44 +0900
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: patchwork-bot+netdevbpf@kernel.org, davem@davemloft.net,
	kuba@kernel.org, linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: pull request: bluetooth 2024-07-26
Message-ID: <ZrZ0BHp5-eHGcaV-@zx2c4.com>
References: <20240807210103.142483-1-luiz.dentz@gmail.com>
 <172308842863.2761812.8638817331652488290.git-patchwork-notify@kernel.org>
 <CABBYNZ+ERf+EzzbWSz3nt2Qo2yudktM_wiV5n3PRajaOnEmU=A@mail.gmail.com>
 <CABBYNZJW7t=yDbZi68L_g3iwTWatGDk=WAfv1acQWY_oG-_QPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZJW7t=yDbZi68L_g3iwTWatGDk=WAfv1acQWY_oG-_QPA@mail.gmail.com>

Hi,

On Fri, Aug 09, 2024 at 11:12:32AM -0400, Luiz Augusto von Dentz wrote:
> Hi,
> 
> On Fri, Aug 9, 2024 at 10:48 AM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Jakub,
> >
> > On Wed, Aug 7, 2024 at 11:40 PM <patchwork-bot+netdevbpf@kernel.org> wrote:
> > >
> > > Hello:
> > >
> > > This pull request was applied to netdev/net.git (main)
> > > by Jakub Kicinski <kuba@kernel.org>:
> > >
> > > On Wed,  7 Aug 2024 17:01:03 -0400 you wrote:
> > > > The following changes since commit 1ca645a2f74a4290527ae27130c8611391b07dbf:
> > > >
> > > >   net: usb: qmi_wwan: add MeiG Smart SRM825L (2024-08-06 19:35:08 -0700)
> > > >
> > > > are available in the Git repository at:
> > > >
> > > >   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-08-07
> > > >
> > > > [...]
> > >
> > > Here is the summary with links:
> > >   - pull request: bluetooth 2024-07-26
> > >     https://git.kernel.org/netdev/net/c/b928e7d19dfd
> > >
> > > You are awesome, thank you!
> >
> > Im trying to rebase on top of net-next but Im getting the following error:
> >
> > In file included from arch/x86/entry/vdso/vgetrandom.c:7:
> > arch/x86/entry/vdso/../../../../lib/vdso/getrandom.c: In function
> > ‘memcpy_and_zero_src’:
> > arch/x86/entry/vdso/../../../../lib/vdso/getrandom.c:18:17: error:
> > implicit declaration of function ‘__put_unaligned_t’; did you mean
> > ‘__put_unaligned_le24’? [-Wimplicit-function-declaration]
> >
> > I tried to google it but got no results, perhaps there is something
> > wrong with my .config, it used to work just fine but it seems
> > something had changed.
> 
> Looks like the culprit is "x86: vdso: Wire up getrandom() vDSO
> implementation", if I revert that I got it to build properly.
> 
> @Jason A. Donenfeld since you are the author of the specific change
> perhaps you can tell me what is going on, my .config is based on:
> 
> https://github.com/Vudentz/BlueZ/blob/master/doc/test-runner.txt

Could you send your actual .config so I can repro?

Thanks,
Jason


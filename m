Return-Path: <netdev+bounces-117297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7526294D7FB
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 22:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0926B1F22EF1
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 20:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8676C15534B;
	Fri,  9 Aug 2024 20:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="o88HNH6V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF1D33D1;
	Fri,  9 Aug 2024 20:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723234872; cv=none; b=WeBZWUSY1muuJK7o40t88R+rcPB/WsSOIl8ISiWAQKY160Ua1GiyL5sgoDiKA9QHBQOZirYhqr9ujZHZfYNOpED2V4uVy/9+Gn0nNQ92Q+SB6vAJxIlz7g3wJQyYqVYNrF0TJIwdgV87M3QWpH0h1wapUpUnzaRreQvN1DsMV6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723234872; c=relaxed/simple;
	bh=Rdd4yoJvIHuSx+yOjYIE/8HgP5trvK5UJl86guIBFLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QHE7zhsfpvmRvPkc1xbleUTPSFCL3dU7EQ+ozcf7VGNwiIBIJh94MgY7fm0KlkhckRFgtG/d6sCFDCPU4eVO08w9W6Ms1yxZvjHPpU5FFp0+atD0BcUzuWskumRIsttCgRDRox3Gr3C+VqNbxefV7aYo9mVkKirlHtLeUuIlUCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=o88HNH6V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A67C32782;
	Fri,  9 Aug 2024 20:21:11 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="o88HNH6V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1723234869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A9AEE/d8q3UBR0Q2JOrO7lyNV+Hda/wwl7QDt4jnd/M=;
	b=o88HNH6VarC2hxUZEiKimHWBteZT5jSoKGWGWB2vVyWSlYfmxHQsCn1PCS2btr/Dznazpi
	aQQVoy8zMOcqAmKYZ/8Y9NfrdnBlWsiKgz9vAjpBMSq3TiwPItkDV3v6CEnl1nuuikZAFN
	ewgWska07k8LGdrcfBha1eqQw9YgYj8=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c2d063df (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Aug 2024 20:21:09 +0000 (UTC)
Date: Sat, 10 Aug 2024 05:21:05 +0900
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: patchwork-bot+netdevbpf@kernel.org, davem@davemloft.net,
	kuba@kernel.org, linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: pull request: bluetooth 2024-07-26
Message-ID: <ZrZ6MUj2egxakWUT@zx2c4.com>
References: <20240807210103.142483-1-luiz.dentz@gmail.com>
 <172308842863.2761812.8638817331652488290.git-patchwork-notify@kernel.org>
 <CABBYNZ+ERf+EzzbWSz3nt2Qo2yudktM_wiV5n3PRajaOnEmU=A@mail.gmail.com>
 <CABBYNZJW7t=yDbZi68L_g3iwTWatGDk=WAfv1acQWY_oG-_QPA@mail.gmail.com>
 <ZrZ0BHp5-eHGcaV-@zx2c4.com>
 <CABBYNZ+3yMdHu77Mz-8jmEgJ-j3WPHD8r_Mhz8Qu-bTJbdspUQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZ+3yMdHu77Mz-8jmEgJ-j3WPHD8r_Mhz8Qu-bTJbdspUQ@mail.gmail.com>

On Fri, Aug 09, 2024 at 04:02:36PM -0400, Luiz Augusto von Dentz wrote:
> Hi Jason,
> 
> On Fri, Aug 9, 2024 at 3:54 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > Hi,
> >
> > On Fri, Aug 09, 2024 at 11:12:32AM -0400, Luiz Augusto von Dentz wrote:
> > > Hi,
> > >
> > > On Fri, Aug 9, 2024 at 10:48 AM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > Hi Jakub,
> > > >
> > > > On Wed, Aug 7, 2024 at 11:40 PM <patchwork-bot+netdevbpf@kernel.org> wrote:
> > > > >
> > > > > Hello:
> > > > >
> > > > > This pull request was applied to netdev/net.git (main)
> > > > > by Jakub Kicinski <kuba@kernel.org>:
> > > > >
> > > > > On Wed,  7 Aug 2024 17:01:03 -0400 you wrote:
> > > > > > The following changes since commit 1ca645a2f74a4290527ae27130c8611391b07dbf:
> > > > > >
> > > > > >   net: usb: qmi_wwan: add MeiG Smart SRM825L (2024-08-06 19:35:08 -0700)
> > > > > >
> > > > > > are available in the Git repository at:
> > > > > >
> > > > > >   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-08-07
> > > > > >
> > > > > > [...]
> > > > >
> > > > > Here is the summary with links:
> > > > >   - pull request: bluetooth 2024-07-26
> > > > >     https://git.kernel.org/netdev/net/c/b928e7d19dfd
> > > > >
> > > > > You are awesome, thank you!
> > > >
> > > > Im trying to rebase on top of net-next but Im getting the following error:
> > > >
> > > > In file included from arch/x86/entry/vdso/vgetrandom.c:7:
> > > > arch/x86/entry/vdso/../../../../lib/vdso/getrandom.c: In function
> > > > ‘memcpy_and_zero_src’:
> > > > arch/x86/entry/vdso/../../../../lib/vdso/getrandom.c:18:17: error:
> > > > implicit declaration of function ‘__put_unaligned_t’; did you mean
> > > > ‘__put_unaligned_le24’? [-Wimplicit-function-declaration]
> > > >
> > > > I tried to google it but got no results, perhaps there is something
> > > > wrong with my .config, it used to work just fine but it seems
> > > > something had changed.
> > >
> > > Looks like the culprit is "x86: vdso: Wire up getrandom() vDSO
> > > implementation", if I revert that I got it to build properly.
> > >
> > > @Jason A. Donenfeld since you are the author of the specific change
> > > perhaps you can tell me what is going on, my .config is based on:
> > >
> > > https://github.com/Vudentz/BlueZ/blob/master/doc/test-runner.txt
> >
> > Could you send your actual .config so I can repro?
> 
> Here it is.

Hmm, I did a clean checkout of net-next, used this .config, and it built
just fine. Any oddities I should look into?

Jason


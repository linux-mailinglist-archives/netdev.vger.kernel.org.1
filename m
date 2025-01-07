Return-Path: <netdev+bounces-155963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12469A0466C
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 17:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 780BC7A03E8
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 16:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659461F76BF;
	Tue,  7 Jan 2025 16:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sfErgvwJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DADB1F4719
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 16:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736267408; cv=none; b=eUOM/PtXH8251Cc/qi1R1bmD404FK0xObhqnqmTUY0WhWLCf6NRqFRI2YgRZP1Kh/U81R8yiUOhdnPJVvJ+EQtsDBHV2gPY19CTf0cc+28C57Xu/ygRt6GImwcT+4kcCIgGG3zV8nmKtPxmQSqgYkI3Qa1NK1CM0fBueUmRZOtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736267408; c=relaxed/simple;
	bh=fKYXLG2DX5G7qGuetkty4+PoQSSQapWZhcdcPRjDkIM=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=g7xsoaCfh3Y8eRiqU+u12kaY+j2k9IgsKcBMFvQKq3HK9x45XJIj1q7XdZwCaAXq1F1gK0VuOlxn7rSkiZUWB5NItsMkD/zZaLS4xwLVWBdgKVt5vcs8anIh7PjkjSsKNGzzaY3zeyNUjdK47ai8R66cAk2EiGcCGHP+qUuML/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sfErgvwJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A4CC4CED6;
	Tue,  7 Jan 2025 16:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736267407;
	bh=fKYXLG2DX5G7qGuetkty4+PoQSSQapWZhcdcPRjDkIM=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=sfErgvwJ3KHW2cnHF2PSoLCWqLQJXWDXZYXyrm74ysFmUDRGN39GlmMXpWRY6nl/c
	 xpTqlFOxM9dOfemIanJBul3+oJ3MVVpI/Mh5ORuKOf7yHq6lQIoa14sgdsJNHpBMvB
	 XXy7Ydt/2pRPMdfM7YrUiAm2WrbndWRbhtL/5/seS+NKh90Bz2xEUSE/sW0gEaAY0b
	 Sl6p0leCU3dE1PWm6cxxGnMUsMmX9Uec2WwnYmzfQB6IWjmvhh/I56JHTu+8Y74KUy
	 HETWYUSKLsi8dfqq1jh5Z9mxaWT2x3UraKg4tqxUp5R70xBfpr+VBtGyo5irwi8snJ
	 oRzO1O08kUjvg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250102143647.7963cbfd@kernel.org>
References: <20231018154804.420823-1-atenart@kernel.org> <20231018154804.420823-2-atenart@kernel.org> <20250102143647.7963cbfd@kernel.org>
Subject: Re: [RFC PATCH net-next 1/4] net-sysfs: remove rtnl_trylock from device attributes
From: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, netdev@vger.kernel.org, gregkh@linuxfoundation.org, mhocko@suse.com, stephen@networkplumber.org
To: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 07 Jan 2025 17:30:03 +0100
Message-ID: <173626740387.3685.11436966751545966054@kwain>

Hi Jakub,

Quoting Jakub Kicinski (2025-01-02 23:36:47)
> On Wed, 18 Oct 2023 17:47:43 +0200 Antoine Tenart wrote:
> > We have an ABBA deadlock between net device unregistration and sysfs
> > files being accessed[1][2]. To prevent this from happening all paths
> > taking the rtnl lock after the sysfs one (actually kn->active refcount)
> > use rtnl_trylock and return early (using restart_syscall)[3] which can
> > make syscalls to spin for a long time when there is contention on the
> > rtnl lock[4].
>=20
> I was looking at the sysfs locking, and ended up going down a very
> similar path. Luckily lore search for sysfs_break_active_protection()
> surfaced this thread so I can save myself some duplicated work :)

Seeing that thread in my inbox again is a nice surprise :-)

Did you encounter any specific issue that made you look at the sysfs
locking?

> Is there any particular reason why you haven't pursued this solution
> further? I think it should work.

I felt there wasn't much interest and feedback at the time and we had
things in place to ease the initial issue we were working on (~ slow
boot time w/ lots of netns and containers). With that and given the
change was a bit tricky I didn't wanted to be the only one pushing for
this.

But I still think this could be beneficial for various use cases so if
you're interested I'll be happy to revive it. I'll have to refresh my
mind and run some tests again first. (Any additional testing will be
appreciated too).

> My version, FWIW:
> https://github.com/kuba-moo/linux/commit/2724bb7275496a254b001fe06fe20ccc=
5addc9d2

I might take a few of your changes in there, eg. I see you used an
interruptible lock. With this and the few minors comments this RFC got I
can prepare a new series.

Thanks!
Antoine


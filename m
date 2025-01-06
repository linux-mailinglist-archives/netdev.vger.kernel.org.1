Return-Path: <netdev+bounces-155593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5481BA031FA
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 22:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C49513A0416
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 21:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DE61D61B1;
	Mon,  6 Jan 2025 21:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPr2aZUI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7515215886C
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 21:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736198453; cv=none; b=KZ7bbXfJoVCbObA936Ll5x4nsbtPLM661hmeqqiHnlslpIyWaHw5z2yCcqh0ta/NJNmpsq3Xyh5d5hkZhi3zvscuhP1cRemBvTPNUINavW5Ws2xkiZqriamEx7NkhdCIrLsd3KbuGXjFVqed6DKjoWUl9isNGVK1neLeMWIQpbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736198453; c=relaxed/simple;
	bh=wOY8xTzFdt+MpgmZUirwXui4NFYi50OD74NKjZlDp0w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ttA40z/keB7u0XMsBPTP3NVBh4hq3HCJMZWuBs/svem339y8m+VFgZdtmuqqJuJjRuR5lzcxkRjpXAW1ks7GZ4xgSxhYUe29sQXyhjAa22K3ZpzRftNfcPKiuT95p2EZYMiVlMbYFw4h3h1nUJWxDbaO6YuKPHSLwKnB8oR+gP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPr2aZUI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8C65C4CED2;
	Mon,  6 Jan 2025 21:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736198453;
	bh=wOY8xTzFdt+MpgmZUirwXui4NFYi50OD74NKjZlDp0w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FPr2aZUIddkpm7GUY8H8wfBfzA3FWS5W1sE4B5xPReuQ3ItKlBP5usjqSLCwuFDOI
	 C8cHH0kUcbF+iv8RZonSs4v1wb1442SXTwZLlFORYwLCoBSPGLj5cmMGtXh3IDeuO3
	 sdqiz3KK0awTzAwa8RfJeAjTQjzv0yroksCINYEYiCqf0cwDwWOXpCIix9+SzXi5sn
	 xTccSZEPt+ulznrCo51XlsCO14qhfb3GUCCNpBiZDAnOh6jHiSzwUboWQj79ADLkuR
	 /LSWZdh2cPEswnjJTK4IvCNqY3neFhFUun8IVuP85gitovP8AAROlne4QF8WDDxhvl
	 HpIdKliB7B1MA==
Date: Mon, 6 Jan 2025 13:20:51 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Teodor Milkov <zimage@icdsoft.com>
Cc: netdev@vger.kernel.org, <mst@redhat.com>, <jasowang@redhat.com>
Subject: Re: Download throttling with kernel 6.6 (in KVM guests)
Message-ID: <20250106132051.262177da@kernel.org>
In-Reply-To: <d1f083ee-9ad2-422c-9278-c50a9fbd8be4@icdsoft.com>
References: <e831515a-3756-40f6-a254-0f075e19996f@icdsoft.com>
	<d1f083ee-9ad2-422c-9278-c50a9fbd8be4@icdsoft.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 6 Jan 2025 22:15:37 +0200 Teodor Milkov wrote:
> Hello,
>=20
> Following up on my previous email, I=E2=80=99ve found the issue occurs=20
> specifically with the |virtio-net| driver in KVM guests. Switching to=20
> the |e1000| driver resolves the slowdown entirely, with no throttling in=
=20
> subsequent downloads.
>=20
> The reproducer and observations remain the same, but this detail might=20
> help narrow down the issue.

Let's CC the virtio maintainers, then.

The fact that a 300ms sleep between connections makes the problem=20
go away is a bit odd from the networking perspective.

You may need to find a way to automate the test and try to bisect=20
it down :( This may help: https://github.com/arighi/virtme-ng

> > We've encountered a regression affecting downloads in KVM guests after=
=20
> > upgrading to Linux kernel 6.6. The issue is not present in kernel 5.15=
=20
> > or the stock Debian 6.6 kernel on hosts (not guests) but manifests=20
> > consistently in kernels 6.6 and later, including 6.6.58 and even 6.13-r=
c.
> >
> > Steps to Reproduce:
> > 1. Perform multiple sequential downloads, perhaps on a link with=20
> > higher BDP (USA -> EU 120ms in our case).
> > 2. Look at download speeds in scenarios with varying sleep intervals=20
> > between the downloads.
> >
> > Observations:
> > - Kernel 5.15: Reaches maximum throughput (~23 MB/s) consistently.
> > - Kernel 6.6:
> > =C2=A0 - The first download achieves maximum throughput (~23 MB/s).
> > =C2=A0 - Subsequent downloads are throttled to ~16 MB/s unless a sleep=
=20
> > interval =E2=89=A5 0.3 seconds is introduced between them.
> >
> > Reproducer Script:
> > for _ in 1 2; do=C2=A0 curl http://example.com/1000MB.bin --max-time 8 =
-o=20
> > /dev/null -w '(%{speed_download} B/s)\n'; sleep 0.1=C2=A0=C2=A0 ;done
> >
> >
> > Tried various sysctl settings, changing qdiscs, tcp congestion algo=20
> > (e.g. from bbr to cubic), but the problem persists.
> >
> > git bisect traced the regression to commit dfa2f0483360 ("tcp: get rid=
=20
> > of sysctl_tcp_adv_win_scale"). While a similar issue described by=20
> > Netflix in=20
> > https://netflixtechblog.com/investigation-of-a-cross-regional-network-p=
erformance-issue-422d6218fdf1=20
> > and was supposedly fixed in kernels 6.6.33 and 6.10, the problem=20
> > remains in 6.6.58 and even 6.13-rc for our case.
> >
> > Could this behavior be a side effect of `tcp_adv_win_scale` removal,=20
> > or is it indicative of something else?
> >
> > We would appreciate any insights or guidance how to further=20
> > investigate this regression.
> >
> > Best regards!
> > =20



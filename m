Return-Path: <netdev+bounces-240439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27787C7508A
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 16:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 9AABF32387
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 15:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3084B36C0B9;
	Thu, 20 Nov 2025 15:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqCuLRSk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA543590B8;
	Thu, 20 Nov 2025 15:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763652080; cv=none; b=cvRGImxUDLnLk95irTNXSgvGeFqGEeJzvmmxBNJlb4SAqkIflnVusrDAW5CHxbcQEaU9MuUqPH0D0bOvzbDknM4v1BaTWztaK2f3ReiSPPpqwPQPkBZueQuApS5y7xbzduoP3nX4q2/684KYQt4/jCJ4vpgZ+NLuHG+JMrDRylY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763652080; c=relaxed/simple;
	bh=buDCAMI5mZImt0zXdAYcWmH8JrqOA00Yws+BDX2HOPM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V5C5HWKwWm9XC6cJPfzaNiydblwwoD9tNshoX12NAoz8XUwkKC6SFYeBEJ9zyd2Uwq2bqb9NCl2qQcoJGmnAZuVqrAJ2vWDWsVAiBVuMs4jRjddtUdR9Z/rQzGUaqz0FQ7BsPf+ayiQntdttU0382Hv/ricdUQ7BeEYLgflnNc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RqCuLRSk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18F59C4CEF1;
	Thu, 20 Nov 2025 15:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763652079;
	bh=buDCAMI5mZImt0zXdAYcWmH8JrqOA00Yws+BDX2HOPM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RqCuLRSk7GJxnQyzKtUOsrkVeSiiobVJbdjQSCnQ7kHgQiG1IKVXuz36AyF5vcI/p
	 nFki1rqoo31/aKKwA0Y3h7NonKOPr3ugXD74C0ylyXBUYAbpESvUw8Id51i7rd9xmb
	 bn2FgzgTakqSGzAJmTF1ZXTlWYdXWxAuFHtWO20wb6bnlEJ1zfzqU3bm3A5UfV9/xB
	 XGIofcyllBDxFG5JD6fv/89wnzfBpvO+eWS4D1SUX1FiMXFNwZDFpliN5u6X+t7qu6
	 Gmi9HaNymhGH34Y6FNNZEbzZujrFC5bn/eu+Jljv8JzClMEoLWYcMbywUDCGM7cMsJ
	 zAPhGjJr4WSgA==
Date: Thu, 20 Nov 2025 07:21:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
Cc: Eric Dumazet <edumazet@google.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <andrey.bokhanko@huawei.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Paolo
 Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 05/13] ipvlan: Fix compilation warning about
 __be32 -> u32
Message-ID: <20251120072118.60f64ee7@kernel.org>
In-Reply-To: <4e73c06e-fec9-4760-804a-eeca0d44943d@huawei.com>
References: <20251118100046.2944392-1-skorodumov.dmitry@huawei.com>
	<20251118100046.2944392-6-skorodumov.dmitry@huawei.com>
	<CANn89iJvwF==Kz5GGMxdgM6E8tF8mOk0gUqSt2Lgse-Cvpo9=g@mail.gmail.com>
	<20251118172612.1f2fbf7f@kernel.org>
	<4e73c06e-fec9-4760-804a-eeca0d44943d@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 20 Nov 2025 14:15:07 +0300 Dmitry Skorodumov wrote:
> On 19.11.2025 04:26, Jakub Kicinski wrote:
> > On Tue, 18 Nov 2025 04:47:03 -0800 Eric Dumazet wrote: =20
> >> On Tue, Nov 18, 2025 at 2:01=E2=80=AFAM Dmitry Skorodumov
> >> This is not a compilation warning, but a sparse related one ?
> >>
> >> This patch does not belong to this series, this is a bit distracting.
> >>
> >> Send a standalone patch targeting net tree, with an appropriate Fixes:=
 tag
> >>
> >> Fixes: 2ad7bf363841 ("ipvlan: Initial check-in of the IPVLAN driver.")=
 =20
> > Not sure we should be sending Linus "fixes" for false positive sparse
> > warnings at rc7/final..
>=20
> Not sure how to proceed! Is it op if I send this path as "net-next"?

Dunno what's "op", but try net-next again if nobody disagrees with me.


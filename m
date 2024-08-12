Return-Path: <netdev+bounces-117859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC90794F90B
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 23:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AD861C21DEF
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 21:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1EC197531;
	Mon, 12 Aug 2024 21:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gfSYWFcz"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2FC186E3C;
	Mon, 12 Aug 2024 21:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723498989; cv=none; b=ZZheVCOA3KZqmDd3x/vFJNUyWqL7E6KRwqytgHAvDz0sa/UNGrTlYRZ16Q8byi19WViQcT1zsfMoVAWd+eZ1QK2D9uWImeQSKY4pRPB5Wq301SktItMbCK+XPh/YNScqnJvNRkUsGt2qs/wVbAOV3lrdoi9spO07mryb1mfEHGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723498989; c=relaxed/simple;
	bh=1YicVVsFsQ7IT1w9ZPZCb4kbLLF28+VO0GcelwLM2LY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JGxQQgpLRLr83a4Ym0DbbzV1Zh88n4YVayX4ydkGEwl6m6nA3y/cVq6kE6U47tvJhIhDYOO6Hxec88ADqBx60oi5oycQYfAwGeQyKOX5YjiO7s/RZkMjNST4lH4nseJVjgUMTRL9MNF5er8/Hlde8Kq6HORVWpmzwO+zTJdShuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gfSYWFcz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=/DsQFtZsoWTGXRj8x/ckpz5zLdJncXQdBv0zIiIWDvo=; b=gf
	SYWFczD+N33OW1eFfWb9DuJmJJv7XZYWfZeRS6XXl37DV/HDEr7rQRVBS+aLaneO6Xx/Rk4zBXGQI
	NpbnMzY3q0tUVG16YKvaBl2zXOr4FJOtKJI3IjTbs6lGtBQ2JYPXKnllHl4vLM1hjnVQ9G/Wp5nls
	9UJiyYN/GvK7TwA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sdcoY-004ci5-6s; Mon, 12 Aug 2024 23:42:54 +0200
Date: Mon, 12 Aug 2024 23:42:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org, o.rempel@pengutronix.de
Subject: Re: [PATCH net-next 2/3] net: ag71xx: use devm for
 of_mdiobus_register
Message-ID: <38c43119-4158-4be8-8919-f6890a5f4722@lunn.ch>
References: <20240812190700.14270-1-rosenp@gmail.com>
 <20240812190700.14270-3-rosenp@gmail.com>
 <ae818694-e697-41cc-a731-73cd50dd7d99@lunn.ch>
 <CAKxU2N9p4DrbREqHuagmVS=evjK48SWE5NM3RbD5zF6D-H93kA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKxU2N9p4DrbREqHuagmVS=evjK48SWE5NM3RbD5zF6D-H93kA@mail.gmail.com>

On Mon, Aug 12, 2024 at 02:35:45PM -0700, Rosen Penev wrote:
> On Mon, Aug 12, 2024 at 2:28 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > On Mon, Aug 12, 2024 at 12:06:52PM -0700, Rosen Penev wrote:
> > > Allows removing ag71xx_mdio_remove.
> > >
> > > Removed local mii_bus variable and assign struct members directly.
> > > Easier to reason about.
> >
> > This mixes up two different things, making the patch harder to
> > review. Ideally you want lots of little patches, each doing one thing,
> > and being obviously correct.
> >
> > Is ag->mii_bus actually used anywhere, outside of ag71xx_mdio_probe()?
> > Often swapping to devm_ means the driver does not need to keep hold of
> > the resources. So i actually think you can remove ag->mii_bus. This
> > might of been more obvious if you had first swapped to
> > devm_of_mdiobus_register() without the other changes mixed in.
> not sure I follow. mdiobus_unregister would need to be called in
> remove without devm. That would need a private mii_bus of some kind.
> So with devm this is unneeded?

If you use devm_of_mdiobus_register(), the device core will call
devm_mdiobus_unregister() on remove. Your patch removed
mdiobus_unregister() in remove....

Is there any user of ag->mii_bus left after converting to
devm_of_mdiobus_register()?

	Andrew


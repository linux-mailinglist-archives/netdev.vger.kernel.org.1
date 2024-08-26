Return-Path: <netdev+bounces-122034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B40295FA03
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 21:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 101F8283543
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 19:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA73A137747;
	Mon, 26 Aug 2024 19:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rKRZgEPC"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D133B54648;
	Mon, 26 Aug 2024 19:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724702061; cv=none; b=cstMxva6WSPl0rPKFo3b/UiiCdGCAh5x1L0aVbEn/WIJC9wFHLLF/89620OjNK6xuzCKKp5TIWrtVLn7A8qJ24/vfhn+b13zou3vbvNsbaO96W1ekK+Mrb9LckVKcapzuu94J9oBXgX7P1cP6ML+jPfMT9oaG/oEQZpLM6tAso0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724702061; c=relaxed/simple;
	bh=gI6Ai6tK6P2zKG+d+WGllCJ/go1LWJsX4G1SD0aWtmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jcRz4vdy2LBK9AyOJm/6cC8rcbocjag629RmL2l289iQW+s29gRWYS7j7jLV5zyhKyW42puW4ALKc4vybf5nY8KORRv6NF2gsYEXqPDV8PjR4h/tLTMMEs7SJcHsAQM/qq1IOfxWLgLL8woc8rIsp4x1MiYgXjBVeTEgEUChPZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rKRZgEPC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=/QiKW2jfX5LgbNLp/PHj7gfqW4+wB7HG58cvQMcO79A=; b=rK
	RZgEPChUylo0rhPv37bae2GP5Dy5zImY63Dua9rETMNkAp57QBGCSi05XsospOXEFy3LHryOJjaDC
	ZymqrVMFTcUCXYRluzQ0vnqUvMnYK4Corpl3c7YRL8I1nuq337NwhBulF7V0RbDH79N6wwfuHP5HY
	MN/yz587x85XB1o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sifmz-005kAm-0f; Mon, 26 Aug 2024 21:54:09 +0200
Date: Mon, 26 Aug 2024 21:54:09 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
	o.rempel@pengutronix.de
Subject: Re: [PATCHv3 net-next] net: ag71xx: get reset control using devm api
Message-ID: <19b708fa-b0e0-4124-8f3b-51a9f50eb2a9@lunn.ch>
References: <20240824181908.122369-1-rosenp@gmail.com>
 <20240826095900.0f8f8c89@kernel.org>
 <CAKxU2N8wJkw2zZXkvAF1SOt+La5Kcqyk7f2s+S-JhgMdfNLjQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKxU2N8wJkw2zZXkvAF1SOt+La5Kcqyk7f2s+S-JhgMdfNLjQA@mail.gmail.com>

On Mon, Aug 26, 2024 at 12:26:30PM -0700, Rosen Penev wrote:
> On Mon, Aug 26, 2024 at 9:59 AM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > On Sat, 24 Aug 2024 11:18:56 -0700 Rosen Penev wrote:
> > > -     struct reset_control *mdio_reset;
> > >       struct clk *clk_mdio;
> > >  };
> >
> > If you send multiple patches which depend on each other they must be
> > part of one series. I'll apply the clk_eth patch shortly but you gotta
> > resend this one, our CI couldn't apply and test it.
> Isn't the CI x86 only?

The CI also does more than X86 builds. It checks if you have Cc: all
the needed maintainer, is the patch checkpatch clean, if it is for
stable, have you Cc: stable etc. We want all these things which are
architecture independent to run, but they failed at the very first
step, applying the patch.

	Andrew


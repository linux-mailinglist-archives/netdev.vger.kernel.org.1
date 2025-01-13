Return-Path: <netdev+bounces-157816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41367A0BE04
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 17:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51538162560
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 16:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B741C5D42;
	Mon, 13 Jan 2025 16:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OHxc4Yrt"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1255E24023A
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 16:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736787124; cv=none; b=Su2AksjTMUGOYffRqTeeLcPZqbMUKNTxRNACN6/lpov+TqEDLuCR1c/mBu/OmgXE0EPPerC8vS/ZbAIuGzoq/hLgUUF7Yfp/+hkABcGO+5BjcBGK3RKFH63Mcx7iDxiTLlBrnt0fYenUHG7YKFApwL0vI5iPlqmR+P+LpqBgpEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736787124; c=relaxed/simple;
	bh=26EkaQyZl23pUVsSDpbfvxGnfrHNU7wWOuPnb+FIWeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BzyX35PbNV368NQlp0ZNav+4oDqn6mG6ay/CLuIO205d8Gx71zMCROjgLddUKe3lnLOtd5J24KnPa7QYsg+vejPLG9jHMYO7dQO1cTWA+k9iOBNlR3w3DMxlglnT/DLTo//B7VUvPbEUr0+lvbnEJZkxELqaplhVFdVQ33gLYEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OHxc4Yrt; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=9xV20OW1k2dshuInbdTyeA45/OSpWdw6oAgA56YLhYM=; b=OH
	xc4Yrt5k/8e0/tzCH7QgaQfIXXKXZrp2A8386CzrDXJ25w2dwX6Ww6BNib/BYs/TRgg+Nbr+VsCoi
	YDdWUFS453/p607MfJYhz2mbF5bDArY4i9PQvGl7U/D2wVLqtfim5UkFq+x/k4cqT1+UVLZHHBvM9
	reG7Fu6dSI/QS0E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tXNfT-0049p4-Eh; Mon, 13 Jan 2025 17:51:59 +0100
Date: Mon, 13 Jan 2025 17:51:59 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org
Subject: Re: [PATCH net-next 1/2] net: un-export init_dummy_netdev()
Message-ID: <2bbeb160-789e-4465-90fd-7e69d348188d@lunn.ch>
References: <20250111065955.3698801-1-kuba@kernel.org>
 <CAH-L+nNX-3ervNe-P-a+CA8=nuYkt88QfRbpXsTtpvgXqqzZtA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH-L+nNX-3ervNe-P-a+CA8=nuYkt88QfRbpXsTtpvgXqqzZtA@mail.gmail.com>

On Mon, Jan 13, 2025 at 10:44:37AM +0530, Kalesh Anakkur Purayil wrote:
> On Sat, Jan 11, 2025 at 12:30 PM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > There are no in-tree module callers of init_dummy_netdev(), AFAICT.
> >
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > ---
> >  net/core/dev.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 1a90ed8cc6cc..23e7f6a3925b 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -10782,7 +10782,6 @@ void init_dummy_netdev(struct net_device *dev)
> >         memset(dev, 0, sizeof(struct net_device));
> >         init_dummy_netdev_core(dev);
> >  }
> > -EXPORT_SYMBOL_GPL(init_dummy_netdev);
> >
> >  /**
> >   *     register_netdev - register a network device
> > --
> > 2.47.1
> >
> >
> I can see that "net/xfrm/xfrm_input.c" and "net/mptcp/protocol.c" are
> invoking init_dummy_netdev() in the init routines.

I thought that initially. And then i checked that they can only be
built in. You only need exports for modules.

      Andrew


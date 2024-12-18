Return-Path: <netdev+bounces-152820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B37F69F5D7C
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 04:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B94787A330A
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 03:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3D085C5E;
	Wed, 18 Dec 2024 03:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALJXesLj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B1535963;
	Wed, 18 Dec 2024 03:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734492701; cv=none; b=YAqLMz7ifZANF/KQZPQLR02OHV4ijVrqr9iRSTQu2Jnx/3LIuN/lW+rwAr0NJnrlETsLFPk46HuStnFJrzCp5NQ7RYi8x+oXuDABG5jXSJMaTU/nHw8d5VXX5YfCtB1JVxQ7BbtIZ65gzZBBDsEqx4vd+LxSzFmBskBMnL0pElM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734492701; c=relaxed/simple;
	bh=6M5xYyRJGK4ifkA89YTWgwJ143k4BhwSTq5wsqz+R3o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mGdz9cz5wwkQaG61g4gZFPIVZLMDZsXGTgHO0lQ7VZTiVcNPC54nAo5vuYpJAi9DWc5Rcmw1ZhSyaAZTpzk/O6k/I3AtVQuHTMduA968kD0ka7GH9Vmkienjvc5VrFWd055r7/oMPHfUOMlcstJs1OVQIHrSWFoLSW3mLE19gPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ALJXesLj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1820C4CECE;
	Wed, 18 Dec 2024 03:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734492701;
	bh=6M5xYyRJGK4ifkA89YTWgwJ143k4BhwSTq5wsqz+R3o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ALJXesLjldFC+HS30KK54VwWPfVO/XWIyEi4mG6JoYcG+kvd+FZMvkg8/ucr7H5BR
	 Ip8yOWCp/mvgvndNCKJ9JeR+tn/FUVl7JbI63q/Es1C9lD9HAzqAirBa+5uJhNwl3V
	 VnAj+XgDtD/k8ALBHZ6bzBaW9cli0x82hs/6QRiXrFn0DXCWZezo3v1cOlKDjIbf1t
	 +1dzg54Z5MqpzFZRsT+IbqV/uWk5DaMDw7LZcitHVmmbFBk6Pck+nSfHXEdnxBLEXS
	 2ZRboBCnfLUmwdxNHE6utBuNo+2ccR2ArZXAHzzL6HnSwnyUgCxrZgLPWa3zO94CFd
	 3JQGWtyHUE9Qg==
Date: Tue, 17 Dec 2024 19:31:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Mattias Forsblad
 <mattias.forsblad@gmail.com>
Subject: Re: [PATCH 0/3] dsa: mv88e6xxx: Add RMU enable/disable ops
Message-ID: <20241217193139.47f4c984@kernel.org>
In-Reply-To: <20241216145940.ybbwiige7dhkpzaa@skbuf>
References: <20241215-v6-13-rc1-net-next-mv88e6xxx-rmu-ops-v1-0-87671db17a65@lunn.ch>
	<20241215225910.sbiav4umxiymafj2@skbuf>
	<289fa600-c722-48d7-bfb9-80ff31256cb5@lunn.ch>
	<20241216145940.ybbwiige7dhkpzaa@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Dec 2024 16:59:40 +0200 Vladimir Oltean wrote:
> > > There is a risk that the RMU effort gets abandoned before it becomes
> > > functional. And in that case, we will have a newly introduced rmu_enable()
> > > operation which does nothing.  
> > 
> > True, but i'm more motivated this time, i'm getting paid for the work :-)
> > 
> > And there is one other interested party as well that i know of.
> > 
> > This patch series is fully self contained, so it easy to revert, if
> > this ends up going nowhere.  
> 
> So what's a no-go is introducing code with no user.
> 
> Splitting into 2 sets like this should be fine. You could post a link to
> Github with the complete picture when you post the qca8k refactoring, so
> that we know what to expect next and where things are going. Hopefully
> it makes sense on its own and does not leave loose ends hanging.
> 
> I don't think that squashing multiple logical changes to fit the 15
> patch limit is a good idea.

Yes, we're not religious about the 15 patch rule. If you give it 
an honest try and it doesn't make sense just say so in the cover
letter.


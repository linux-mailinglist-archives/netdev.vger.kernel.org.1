Return-Path: <netdev+bounces-163225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9373BA299EB
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 20:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A3561889D39
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 19:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D3A1FCFDA;
	Wed,  5 Feb 2025 19:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BjbyqDqs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4A01FFC42
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 19:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738782806; cv=none; b=kp99GVwjRwwf66NDtO37WRaAdWqk6/0Hgvx5IZRZQSbU4HtJCzduQYmekPp4VhvoJYvXk8Y12tU+1lppmdGYwezNizykTamjGyLXI8eUZvivPi5iavoiQf8Oj3AFwl70tNOvWriXBAGLCI5tR5YcWLLU+DDADRD2El7MqQZ6wmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738782806; c=relaxed/simple;
	bh=WNGD4b3pjLcrMZIhCpcOanQjwJoVbYOLDuxnVzFZEnY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gafTCcfmlw/ioNK78BUzv1grjMSloNE3Gu5wlx1aRPyyYXLiHlqbMgoEwlXZgU4xR54IjbnNt9p8gsvw0GD3E3CXs/RyvDGG4EUvWoFmIBiQLrjFEe1Oyp3DAVvrez/nBLfhZN+p+oNnc4QBWPke6s7HHa3ahc+BBCIFVB4sULA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BjbyqDqs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59222C4CED1;
	Wed,  5 Feb 2025 19:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738782805;
	bh=WNGD4b3pjLcrMZIhCpcOanQjwJoVbYOLDuxnVzFZEnY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BjbyqDqsClLN8DXX1+/s+FWEj9nxa+WqTAUYbZGihb+J05HBY8QQFJa5sqA+ibkiM
	 Gh4IhemfqA5LUbL/QAt5IHc4aA/EkNOwadLL6FXdJWRvX2B3tMPrKdUz/4MeCwtVDc
	 hF5VImZ/PyvEN8ny/r66fXLxY2wsfWKw7CmLC5N3F+xFhd1zbp2F788XE9A+6POM+x
	 7YIPCLy8e0DpnLg9XWOYsCJoQebyTj8FEmdfj3mgvzrcsJ7RRH4B5S/P0LQe0hjxIY
	 Ugi3FJqvcbu1/w63+OgmriMlOBvbU/CecTC5tAdOKf9Wn7CD1vOnfwa/fXoTGGYvAQ
	 IXkr/2hEdJCRw==
Date: Wed, 5 Feb 2025 11:13:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: netdevsim: Support setting dev->perm_addr
Message-ID: <20250205111324.34db2521@kernel.org>
In-Reply-To: <CANn89iK8YpzNhJv4R+x80hcq794bh_ykS-O-2UHziBXixNhzyA@mail.gmail.com>
References: <20250203-netdevsim-perm_addr-v1-1-10084bc93044@redhat.com>
	<20250203143958.6172c5cd@kernel.org>
	<871pweymzr.fsf@toke.dk>
	<20250204085624.39b0dc69@kernel.org>
	<87seosyd6a.fsf@toke.dk>
	<20250205090000.3eb3cb9d@kernel.org>
	<CANn89iK8YpzNhJv4R+x80hcq794bh_ykS-O-2UHziBXixNhzyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Feb 2025 18:08:00 +0100 Eric Dumazet wrote:
> > > Right. How do you feel about Andrew's suggestion of just setting a
> > > static perm_addr for netdevsim devices?  
> >
> > I don't see how that'd be sufficient for a meaningful test.  
> 
> Perhaps allow IFLA_PERM_ADDRESS to be set at veth creation time,
> or other virtual devices...

I'd rather we didn't sprinkle testing code into real drivers, FWIW.


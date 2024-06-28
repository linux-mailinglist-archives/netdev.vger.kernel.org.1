Return-Path: <netdev+bounces-107857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C989991C9B4
	for <lists+netdev@lfdr.de>; Sat, 29 Jun 2024 01:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FAF11C21DA1
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 23:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BDF84E04;
	Fri, 28 Jun 2024 23:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUeXuh7D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C45C83CDE;
	Fri, 28 Jun 2024 23:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719619161; cv=none; b=UCiUdTf8rsfc2wMhUUQNW5wGB37JQAI3QRAonQx4oGB3e3lqIf/JUkzTGWKMzjZrJboXHlbNzQc5uk0Rmf7IRv8Fv28cUHYXocwedui7DY1tIZOleyrNo4vtyH5mrgrZwuqt/M6QyYbPffXdDRYKl/ojxblurCDuWn3wU59PrYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719619161; c=relaxed/simple;
	bh=sxDweBf8ln7aoL56gCYiqWZ71m71UgzSUkSa93E28mY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mLdgkwDk22q5w6dwNiRrK4G3nhZJWAFWXHxwBtHPPoBFzzyCIB/Qb4hVvMg8ptBQ5/5o80xnAXg/nJSvN3b2hP01qEW5t/YUblvlEPJO1/uk1bDxGym/kd4pZRkhWIXDW3atMhjKGW3NBGwUqWP5sTGLWK69WvYr/V6YzSAd3sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUeXuh7D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 309DBC32781;
	Fri, 28 Jun 2024 23:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719619160;
	bh=sxDweBf8ln7aoL56gCYiqWZ71m71UgzSUkSa93E28mY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LUeXuh7DHAJr+UcfRrAg0nBGm/d62VU7pdiugF3BNtbseAfJpTmN5wFUilmDXRYV9
	 j8igLLyRg/DepDPbtxcrXXWVyKhyjQEzCRbNIaaPCaw2X9PnMhrSfaQZineY0ja4MT
	 7t7tmlb1EtqHxdFFeWJHcsPdTGU0B5r+sn7vASXJm/96ho0oPF2/o8QA8mAqzN/jem
	 KXvi8u7JBVXo5pv0ZR4m9k4pG/Pzdz6IKZvyLkOydXv/gF0Y6WNM3JAYB00TyjfAU4
	 BhPrpL00Gc7lfey03W2j0H5e0Eqb66Rd051Q54WvLCjjrBkPhXVK8k8Ymg8o449znc
	 q8RskxgsFurKA==
Date: Fri, 28 Jun 2024 16:59:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [RESEND PATCH net] net: phy: aquantia: add missing include
 guards
Message-ID: <20240628165919.1a0bc513@kernel.org>
In-Reply-To: <CAMRc=MdmDezxbug461brRRq-zc=ubnyDya3dQzsmuH_6X5Pb8g@mail.gmail.com>
References: <20240627105846.22951-1-brgl@bgdev.pl>
	<20240627145931.480ad134@kernel.org>
	<CAMRc=MdmDezxbug461brRRq-zc=ubnyDya3dQzsmuH_6X5Pb8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Jun 2024 09:56:31 +0200 Bartosz Golaszewski wrote:
> > You say net but it doesn't apply:
> >
> > Applying: net: phy: aquantia: add missing include guards
> > error: patch failed: drivers/net/phy/aquantia/aquantia.h:198
> > error: drivers/net/phy/aquantia/aquantia.h: patch does not apply
> > Patch failed at 0001 net: phy: aquantia: add missing include guards
> > --
> > pw-bot: cr  
> 
> I resent a rebased version. However I noticed I forgot the 'net'
> prefix as I split it out of the previous series. Sorry, I hope it can
> still be applied without resending again.

The bot wasn't clever enough, sorry :( Third time is the charm..


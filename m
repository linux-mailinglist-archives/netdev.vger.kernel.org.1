Return-Path: <netdev+bounces-113429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 823B393E3E5
	for <lists+netdev@lfdr.de>; Sun, 28 Jul 2024 09:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4A3AB21224
	for <lists+netdev@lfdr.de>; Sun, 28 Jul 2024 07:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41F48BEE;
	Sun, 28 Jul 2024 07:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LcpeouRE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E118F77
	for <netdev@vger.kernel.org>; Sun, 28 Jul 2024 07:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722151073; cv=none; b=mI9DJyGM/+MTMQ0f52kl/nxYE6VFYcv13jGUZ4TDHdHN8o5KDKlU9iesELSZyEGlCsqUmydyICoXNvt+CSHvubX0qZg1+5L/w32b0Ohbr5tr2tHi1xJU2LVvXvZgRnzWXXMTGHeupMh89vEkLPDb/1U0VvSM709rHrW/1AhXLCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722151073; c=relaxed/simple;
	bh=L/vP++2fNxukTqTPfdVfAtZlBGmhZnx20GXKKd9M1nI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hPi0ee8MtcqTOwHeBAlZ5uaY1m3Vad1LG1BrgfKhyaDcjh4tlrY7W1BlJ9PUjUHIkYlb820V4tZwRTf+d1d2asMVj2d+pBi2BfD4EGUbYBJ+9SgzvruDkj62TBonlV3br4oS4EntIlIJ/POMBDUdBGc6c7aOfwE2vSBpJU160H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LcpeouRE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA72CC116B1;
	Sun, 28 Jul 2024 07:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722151073;
	bh=L/vP++2fNxukTqTPfdVfAtZlBGmhZnx20GXKKd9M1nI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LcpeouREalGwXicLKnZHXB+7RYX6bcWcqwzIOBYA/XSZQDc04sf2n/9VfQ/sF9WmI
	 2tMtMj0E8bOMPUawyOAodBh5u9pMFw5Dl/u7cEePS6t8WrXB+PNj5/W7G58UoqxP4T
	 MU78FkxXg7V2Pg/yWm8ZMXnWwSzINMK4tiuICWGrnIJwCncpKxtoT/sQClYrKogaWK
	 a8qJbC03euAdA5yj64UtS4YuLh9kpQGVpoWYuBgiejF6o3Uvq760f1QqqptYOab2nE
	 6U0Ani/eOsc01KTi0p8xFijNUma+/ah+Z5X9ygLhCHvnwE8+6tq/1NoDzsNtxdk5bN
	 3rcb6tbe6lSOA==
Date: Sun, 28 Jul 2024 08:17:46 +0100
From: Simon Horman <horms@kernel.org>
To: Patrick Rohr <prohr@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Linux Network Development Mailing List <netdev@vger.kernel.org>,
	Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
	Lorenzo Colitti <lorenzo@google.com>,
	David Lamparter <equinox@opensourcerouting.org>
Subject: Re: [PATCH net-next] Add support for PIO p flag
Message-ID: <20240728071746.GB1625564@kernel.org>
References: <20240726010629.111077-1-prohr@google.com>
 <20240726102318.GN97837@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240726102318.GN97837@kernel.org>

On Fri, Jul 26, 2024 at 11:23:18AM +0100, Simon Horman wrote:
> On Thu, Jul 25, 2024 at 06:06:29PM -0700, Patrick Rohr wrote:
> > draft-ietf-6man-pio-pflag is adding a new flag to the Prefix Information
> > Option to signal the pd-per-device addressing mechanism.
> > 
> > When accept_pio_pflag is enabled, the presence of the p-flag will cause
> > an a flag in the same PIO to be ignored.
> > 
> > An automated test has been added in Android (r.android.com/3195335) to
> > go along with this change.
> > 
> > Cc: Maciej Żenczykowski <maze@google.com>
> > Cc: Lorenzo Colitti <lorenzo@google.com>
> > Cc: David Lamparter <equinox@opensourcerouting.org>
> > Signed-off-by: Patrick Rohr <prohr@google.com>
> 
> Hi Patrick,
> 
> This is not a full review, and as per the form letter below,
> net-next is closed, so you'd be best to repost.
> But I will offer some very minor review in the meantime.
> 
> Firstly, please seed the CC list for Networking patches
> using get_maintainers.pl --git-min-percent 25 this.patch
> 
> Secondly, as noted inline, there are two cases of
> mixed of tabs and spaces used for indenting in this patch.
> 
> ## Form letter - net-next-closed
> 
> The merge window for v6.11 has begun and therefore net-next is closed
> for new drivers, features, code refactoring and optimizations.
> We are currently accepting bug fixes only.
> 
> Please repost when net-next reopens after 15th July

Sorry, I'm not sure why I wrote the 15th, I meant the 29th.

> 
> RFC patches sent for review only are welcome at any time.
> 
> See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle

...


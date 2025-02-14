Return-Path: <netdev+bounces-166432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F426A35FDA
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 15:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0005188DF31
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 14:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA23264FBB;
	Fri, 14 Feb 2025 14:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2la5VeRj"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40508264A7B
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 14:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739541989; cv=none; b=iDJNv3i0OuuIpt1vP8xw6dHhSwb0V0AL66wGD5PIce9eonfECJO6Vu7K5hnVhbjRtRAahNboQ73XnQ5Myy88K9SWJdJCA5Qt8q3MLki6Z0BHWswhJbu/n6LUSsPMEgoaCFQlE5ap/GrKwtBuPGehsNfe0YUZp02qDG9kiX5fN7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739541989; c=relaxed/simple;
	bh=W3iI0MRWaCsaAZecc6J0jrd5mHHI5U7tbCfWFrBQCL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IT64Hk0FbO0eX0uJDISat5FtmIlRaBcv5x7BtFzePz8w/ho+2fQoHM/9yqXRUYAJHA7cyj0vsk8zTVeqVZTb8Uy/9aVRqEvBJntz5gtW2G5lL1i5ayMJbbZ0nv82lmMSkFyYptgAcEv3fO9yeBQDeQQcaLxnEAJGFnzy5Rt9Gjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2la5VeRj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Qo9hqDQo8vot9tXQwxYxqWMMmyH+geXyxmWvgqNKPJU=; b=2la5VeRjHrZQG0cjjAvfSfEu5L
	+kEE9miaPZHcyxuQNSCWVNp4B95pbxf5RZ9c9yOcPWjA7yEi3LCaLDOlFWXUqOXdPWUqGeQ39csX3
	+RW7ES9rN87tEZXcDocN4tkw2yGVkXD//38EQSV2L0ePnmKFoPUUoEvdprdw13+msfSk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tiwKe-00E5P9-1p; Fri, 14 Feb 2025 15:06:16 +0100
Date: Fri, 14 Feb 2025 15:06:16 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	netdev@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] net: dsa: rtl8366rb: Fix compilation problem
Message-ID: <ca426cd1-124a-483e-9426-4a59ed7d7ba4@lunn.ch>
References: <20250214-rtl8366rb-leds-compile-issue-v1-1-c4a82ee68588@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214-rtl8366rb-leds-compile-issue-v1-1-c4a82ee68588@linaro.org>

On Fri, Feb 14, 2025 at 09:59:57AM +0100, Linus Walleij wrote:
> When the kernel is compiled without LED framework support the
> rtl8366rb fails to build like this:
> 
> rtl8366rb.o: in function `rtl8366rb_setup_led':
> rtl8366rb.c:953:(.text.unlikely.rtl8366rb_setup_led+0xe8):
>   undefined reference to `led_init_default_state_get'
> rtl8366rb.c:980:(.text.unlikely.rtl8366rb_setup_led+0x240):
>   undefined reference to `devm_led_classdev_register_ext'
> 
> As this is constantly coming up in different randconfig builds,
> bite the bullet and add some nasty ifdefs to rid this issue.

At least for DSA drivers, it is more normal to put the LED code into a
separate compilation unit and provide stubs for when it is not
used. That avoids a lot of nasty #ifdefs. Could you do the same here?

Thanks
	Andrew


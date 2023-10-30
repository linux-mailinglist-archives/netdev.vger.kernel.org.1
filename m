Return-Path: <netdev+bounces-45268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6207DBC89
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 16:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8B0C281424
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 15:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA1C182A3;
	Mon, 30 Oct 2023 15:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NB0Wy7Aq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1871F18AE1;
	Mon, 30 Oct 2023 15:25:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF14FC433C8;
	Mon, 30 Oct 2023 15:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1698679544;
	bh=btyjpiEdwQ+MufjXyopFOcMveHsu8z12SIfdV1MwW1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NB0Wy7AqZMyCyTj7jPHOyVOmMcV2xXkZ9p/0mLLlOk8ctevt0m08Wy5FWx0uvRNzp
	 zQ4ePKjZSEYIDgB0vLHw05dy6x8M/Nkt/yAYI8CzutUxSYoIaGSXMNxzxhCs7/dS8C
	 wKbp2P2FYs76TuQo1aSSsk62hEfdI2Hl6DsZ/1VE=
Date: Mon, 30 Oct 2023 16:25:40 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Benjamin Poirier <benjamin.poirier@gmail.com>
Cc: Kira <nyakov13@gmail.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Manish Chopra <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
	Coiby Xu <coiby.xu@gmail.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, Sven Joachim <svenjoac@gmx.de>,
	Ian Kent <raven@themaw.net>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: Revert "staging: qlge: Retire the driver"
Message-ID: <2023103001-drew-parmesan-c61a@gregkh>
References: <20231030150400.74178-1-benjamin.poirier@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030150400.74178-1-benjamin.poirier@gmail.com>

On Tue, Oct 31, 2023 at 02:04:00AM +1100, Benjamin Poirier wrote:
> This reverts commit 875be090928d19ff4ae7cbaadb54707abb3befdf.
> 
> On All Hallows' Eve, fear and cower for it is the return of the undead
> driver.
> 
> There was a report [1] from a user of a QLE8142 device. They would like for
> the driver to remain in the kernel. Therefore, revert the removal of the
> qlge driver.
> 
> [1] https://lore.kernel.org/netdev/566c0155-4f80-43ec-be2c-2d1ad631bf25@gmail.com/

Who's going to maintain this?

> Reported by: Kira <nyakov13@gmail.com>
> Signed-off-by: Benjamin Poirier <benjamin.poirier@gmail.com>
> ---
> 
> Notes:
>     Once the removal and revert show up in the net-next tree, I plan to send a
>     followup patch to move the driver to drivers/net/ as discussed earlier:
>     https://lore.kernel.org/netdev/20231019074237.7ef255d7@kernel.org/

are you going to be willing to maintain this and keep it alive?

I'm all this, if you want to, but I would like it out of staging.  So
how about applying this, and a follow-on one that moves it there once
-rc1 is out?  And it probably should be in the 'net' tree, as you don't
want 6.7 to come out without the driver at all, right?

> +QLOGIC QLGE 10Gb ETHERNET DRIVER
> +M:	Manish Chopra <manishc@marvell.com>
> +M:	GR-Linux-NIC-Dev@marvell.com
> +M:	Coiby Xu <coiby.xu@gmail.com>
> +L:	netdev@vger.kernel.org
> +S:	Supported
> +F:	Documentation/networking/device_drivers/qlogic/qlge.rst
> +F:	drivers/staging/qlge/

It's obvious taht these people are not maintaining this code, so they
should be dropped from the MAINTAINERS file as well.

thanks,

greg k-h


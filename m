Return-Path: <netdev+bounces-15287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D19EF7469E8
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 08:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5EDB280ED3
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 06:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C8B7E3;
	Tue,  4 Jul 2023 06:47:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4DD7C
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 06:47:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D424C433C8;
	Tue,  4 Jul 2023 06:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1688453254;
	bh=NKrgqMucYEDaZ3CZ4vWlOu9Bpv3mE+2DG7gfJNFcPwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CiF0+pTUEjiABNYtUnUCtbcuLin2yOxkmmIszTzS6elUqzFrs2i1PkNechNBDjFov
	 KQk640h3FVDpDJZ4wIKqSd/vRyJnvTluls3jYVb1/rDGlC/KYjRJm04xemR0vaxuuG
	 qT4pbWxAM57tdXt6/gqrnGsVfN7GBGBdQh+ybd0A=
Date: Tue, 4 Jul 2023 07:47:31 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Enrico Mioso <mrkiko.rs@gmail.com>
Cc: Jan Engelhardt <jengelh@inai.de>, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kalle Valo <kvalo@kernel.org>,
	Oleksij Rempel <linux@rempel-privat.de>,
	Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
	Jacopo Mondi <jacopo@jmondi.org>,
	=?utf-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	Ilja Van Sprundel <ivansprundel@ioactive.com>,
	Joseph Tartaro <joseph.tartaro@ioactive.com>
Subject: Re: [PATCH] USB: disable all RNDIS protocol drivers
Message-ID: <2023070430-fragment-remember-2fdd@gregkh>
References: <20221123124620.1387499-1-gregkh@linuxfoundation.org>
 <n9108s34-9rn0-3n8q-r3s5-51r9647331ns@vanv.qr>
 <ZKM5nbDnKnFZLOlY@rivendell>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKM5nbDnKnFZLOlY@rivendell>

On Mon, Jul 03, 2023 at 11:11:57PM +0200, Enrico Mioso wrote:
> Hi all!!
> 
> I think the rndis_host USB driver might emit a warning in the dmesg, but disabling the driver wouldn't be a good idea.
> The TP-Link MR6400 V1 LTE modem and also some ZTE modems integrated in routers do use this protocol.
> 
> We may also distinguish between these cases and devices you might plug in - as they pose different risk levels.

Again, you have to fully trust the other side of an RNDIS connection,
any hints on how to have the kernel determine that?

thanks,

greg k-h


Return-Path: <netdev+bounces-16855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DE374F033
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 15:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D16471C20F43
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 13:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08D918C20;
	Tue, 11 Jul 2023 13:33:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8109017755
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 13:33:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A40C433C7;
	Tue, 11 Jul 2023 13:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689082384;
	bh=JLpKJHGa4QT4OzQjT4GJbvB8G8yu+7yongiCOHpJjb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mz2lgffXa5p11q4yQlij2u45AJ1V1F6jqyyUPP/+AAZ2UUOIV44u7fczefkjDjVRq
	 XNXuuWCzgMk4ePmc2l3jCm0Q2s8ZoBHnxbAwrG3LUpbD2kxcbZyC/hCpU3uP1XRIeu
	 ENDl4OaGqPDwhwhnHQCT/wg5K9u7Km2z1IM/GJR5htz/b8as2EseYJVS2mLqqWmO+N
	 1rgBM9LIhXq9mac5rXbBNyU/zNQYHh1LWB6lZrgJVXpXxpd1VA0BqSkNAGLJWJM7fQ
	 JU9lkFsF4/0OdfKXcKRO37CO5P9fqWEFtUhPoyw1FT+bDxR9OcRiNm2WefpIO8FkyX
	 6S17+zpIfpDsQ==
Date: Tue, 11 Jul 2023 16:32:59 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next][resend v1 1/1] netlink: Don't use int as bool
 in netlink_update_socket_mc()
Message-ID: <20230711133259.GS41919@unreal>
References: <20230710100624.87836-1-andriy.shevchenko@linux.intel.com>
 <20230711063348.GB41919@unreal>
 <2a2d55f167a06782eb9dfa6988ec96c2eedb7fba.camel@redhat.com>
 <ZK002l0AojjdJptC@smile.fi.intel.com>
 <20230711122012.GR41919@unreal>
 <ZK1O7lBF1vH7/7UM@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZK1O7lBF1vH7/7UM@smile.fi.intel.com>

On Tue, Jul 11, 2023 at 03:45:34PM +0300, Andy Shevchenko wrote:
> On Tue, Jul 11, 2023 at 03:20:12PM +0300, Leon Romanovsky wrote:
> > On Tue, Jul 11, 2023 at 01:54:18PM +0300, Andy Shevchenko wrote:
> > > On Tue, Jul 11, 2023 at 12:21:12PM +0200, Paolo Abeni wrote:
> > > > On Tue, 2023-07-11 at 09:33 +0300, Leon Romanovsky wrote:
> > > > > On Mon, Jul 10, 2023 at 01:06:24PM +0300, Andy Shevchenko wrote:
> 
> ...
> 
> > > > > So what is the outcome of "int - bool + bool" in the line above?
> > > 
> > > The same as with int - int [0 .. 1] + int [0 .. 1].
> > 
> > No, it is not. bool is defined as _Bool C99 type, so strictly speaking
> > you are mixing types int - _Bool + _Bool.
> 
> 1. The original code already does that. You still haven't reacted on that.

The original code was int - int + int.

> 2. Is what you are telling a problema?

No, I'm saying that you took perfectly correct code which had all types
aligned and changed it to have mixed type arithmetic.

Thanks

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 


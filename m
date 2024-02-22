Return-Path: <netdev+bounces-74182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBDA860628
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 00:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62329286834
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 23:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FD5182A3;
	Thu, 22 Feb 2024 23:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YAEKY+CS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006FB17BD3
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 23:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708642833; cv=none; b=Jc75wCTEg+waayokrH0Q/q4gYvSvYDqEjYW2ccPomCQ0is2r5n9MaR+wDwRLNfUiheB6w+dzPQ+N8biUQG42aaq19gNzXOUt6yKlp7k1nKmiOWHMBdhGMcGD0Zo8dynqm40YzTqsC2LGoDFgvxvJHoCnVYnT7fsb7cflSNiFGIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708642833; c=relaxed/simple;
	bh=VtJ0eNvCZl8+oRsMBM4HRZW7hjUS8RXtPC1OGbv/zZs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pgwRn+ep3vle8xHF1BFFLaNkEJZ+/WrqV7K80fXl4iEQt9r5dmDCxkPjPHIkkPZjwhjtpvDKZDJfUvQmuFxeknvpyx8hmjXWaceoDoyBEBdPHPM6hhhr6DvnUBvriHPUInthSjtrUEHEOrMk+wr5hKrdKATjbvF9zU8qPJ3f5Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YAEKY+CS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBB9FC433C7;
	Thu, 22 Feb 2024 23:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708642832;
	bh=VtJ0eNvCZl8+oRsMBM4HRZW7hjUS8RXtPC1OGbv/zZs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YAEKY+CSY9eGDdo/FAswXt28gBZVM4EKpPaqWI/zUUS5dKImV8LtPn0iiV4QW0cHI
	 5X42RclYHdM2tObiJGsX60+2samBRtR5xXTx7JAqLhclIxoM7Cvu5KRN9gpEHPfbEI
	 GBmKQDxJfeZyrvC8FEspp9BjreLcNSGkeLoLAXiNDlYTqOG7A7UrWvC8/I2oMpGC04
	 iOk3gcObeFstQdQ/KhXP6gLfQ+yJuJtbjkGDX/fbD8xicuk4WlsMld+tGr1e0+y0kW
	 NoPne3CcWPTSfJe+lniCwuISWgn2mQJgtWuwZ8RZ+hV/WWwWw7e10gM/2Q1xUaQNTf
	 9aSCoUk2qRSBg==
Date: Thu, 22 Feb 2024 15:00:30 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tariq Toukan <ttoukan.linux@gmail.com>, Saeed Mahameed
 <saeed@kernel.org>, "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Saeed Mahameed
 <saeedm@nvidia.com>, netdev@vger.kernel.org, Tariq Toukan
 <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
 <leonro@nvidia.com>
Subject: Re: [net-next V3 15/15] Documentation: networking: Add description
 for multi-pf netdev
Message-ID: <20240222150030.68879f04@kernel.org>
In-Reply-To: <2024022214-alkalize-magnetize-dbbc@gregkh>
References: <20240215030814.451812-1-saeed@kernel.org>
	<20240215030814.451812-16-saeed@kernel.org>
	<20240215212353.3d6d17c4@kernel.org>
	<f3e1a1c2-f757-4150-a633-d4da63bacdcd@gmail.com>
	<20240220173309.4abef5af@kernel.org>
	<2024022214-alkalize-magnetize-dbbc@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Feb 2024 08:51:36 +0100 Greg Kroah-Hartman wrote:
> On Tue, Feb 20, 2024 at 05:33:09PM -0800, Jakub Kicinski wrote:
> > Greg, we have a feature here where a single device of class net has
> > multiple "bus parents". We used to have one attr under class net
> > (device) which is a link to the bus parent. Now we either need to add
> > more or not bother with the linking of the whole device. Is there any
> > precedent / preference for solving this from the device model
> > perspective?  
> 
> How, logically, can a netdevice be controlled properly from 2 parent
> devices on two different busses?  How is that even possible from a
> physical point-of-view?  What exact bus types are involved here?

Two PCIe buses, two endpoints, two networking ports. It's one piece
of silicon, tho, so the "slices" can talk to each other internally.
The NVRAM configuration tells both endpoints that the user wants
them "bonded", when the PCI drivers probe they "find each other"
using some cookie or DSN or whatnot. And once they did, they spawn
a single netdev.

> This "shouldn't" be possible as in the end, it's usually a PCI device
> handling this all, right?

It's really a special type of bonding of two netdevs. Like you'd bond
two ports to get twice the bandwidth. With the twist that the balancing
is done on NUMA proximity, rather than traffic hash.

Well, plus, the major twist that it's all done magically "for you"
in the vendor driver, and the two "lower" devices are not visible.
You only see the resulting bond.

I personally think that the magic hides as many problems as it
introduces and we'd be better off creating two separate netdevs.
And then a new type of "device bond" on top. Small win that
the "new device bond on top" can be shared code across vendors.

But there's only so many hours in the day to argue with vendors.


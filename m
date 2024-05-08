Return-Path: <netdev+bounces-94605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F20958BFFB0
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 16:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77427B276A8
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 14:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5649084E03;
	Wed,  8 May 2024 14:02:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791025228;
	Wed,  8 May 2024 14:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715176953; cv=none; b=ki59n18+CfAaAhGoav+eOTmBL44UR1WjUmusRiGX/kXK56ZWtFhsTdL+9O9YO69cGpG/UJd2BjOjv/Y74Kd0UQyfo9y20obbiu6kwsH4cid3BzWDAEvn7NqVosZ/AA1KhTkr/ls3gcmEHxtcmVE3pgpUElzEdxALEBEY5ACKV38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715176953; c=relaxed/simple;
	bh=w4waNtjf0iC2E/lCdV/34ys04fC59YCnAQ/WZGWzaVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lWbygC39PTRkDpwmOui+InzuZnwpGijZDJx9IBc/jz8euc/dw9dRx0G9RH9/7ujKpb3cbBgtNkjHRJbClxrTITHt3569RdQFLhBZDyBcaxdFvgO4Y9n6ctodieavz9RY2RHYgneQiGD09SO33X3IETXM20mkUpk8SKv5eFltDEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.97.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1s4hs5-000000002fw-0jV9;
	Wed, 08 May 2024 14:02:13 +0000
Date: Wed, 8 May 2024 15:02:08 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Sky Huang <SkyLake.Huang@mediatek.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Qingfang Deng <dqfext@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Steven Liu <Steven.Liu@mediatek.com>
Subject: Re: [PATCH 2/3] net: phy: mediatek: Add mtk phy lib for token ring
 access & LED/other manipulations
Message-ID: <ZjuF4L8xIwDqyMad@makrotopia.org>
References: <20240425023325.15586-1-SkyLake.Huang@mediatek.com>
 <20240425023325.15586-3-SkyLake.Huang@mediatek.com>
 <Zjo9SZiGKDUf2Kwx@makrotopia.org>
 <a005409e-255e-4633-a58c-6c29e6708b34@lunn.ch>
 <Zjt5iobHklvrVgtB@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zjt5iobHklvrVgtB@shell.armlinux.org.uk>

On Wed, May 08, 2024 at 02:09:30PM +0100, Russell King (Oracle) wrote:
> On Wed, May 08, 2024 at 02:25:56PM +0200, Andrew Lunn wrote:
> > Please trim the email when replying to just what is relevant. If i
> > need to page down lots of time to find a comment it is possible i will
> > skip write passed a comment...
> 
> +1. There are _too_ _many_ people on netdev who just don't bother to do
> this, and it's getting to the point where if people can't be bothered
> to make it easier for me to engage with them, I'm just not going to be
> bothered engaging with them. People need to realise that this is a two-
> way thing, and stop making reviewers have extra work trying to find
> their one or two line comment buried in a few hundred lines of irrevant
> content. I might just send a reply, top posting, stating I can't be
> bothered to read their email.

Sorry about that, note taken. I'll take better care of that in future.


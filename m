Return-Path: <netdev+bounces-86455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8291A89ED84
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 10:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B429A1C20A10
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 08:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2588613D529;
	Wed, 10 Apr 2024 08:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KDPNsaBu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF92713D28C;
	Wed, 10 Apr 2024 08:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712737530; cv=none; b=o3jja0yQJpTEwB0rq26bhgi0WUADORTF5HRKXWB4svc7rcQzGRj/UVQxeidkgszKzEw7i2C9hGNYwRvyEsDoIRTlva14p/fjPBZGv8iowOHl+g6qTqSH9z3RiUbCvC+nVsYn234Cd0FOt8q5ypXEYaMOI0rORNWSvNrU1HymJQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712737530; c=relaxed/simple;
	bh=Dhybrf/jRqbpyhuhIWlZvPbxMVOS0VFGt4WJR1DnMNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QEP5a3yxzv34+8rBOFqL+kaWJlP5HTWnRaoVzP7ghvAfZKIX8KB6tNHcy1Out81LnGIt7GsnbWtSIAm7v0vZcAou8KVmsUVdHsDhy58Bz3VmeMOf7OdyiAy08bjLgBXUPWhFhqUhF+srloiU6E3TaWjHlzbzLLh92UNo7PU5sec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KDPNsaBu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 222B4C433F1;
	Wed, 10 Apr 2024 08:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712737529;
	bh=Dhybrf/jRqbpyhuhIWlZvPbxMVOS0VFGt4WJR1DnMNo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KDPNsaBudn+n4+RXzxU38zA293P9i01hK4pr+EzsNlygvUAPOjzwvf/oUbikrXg95
	 /N9KFTY1uuvoJgBUoJH4BkRDQEIr3X5LSBVt6P6w3X2XFz+Etf1/yCAYNPWYH2L813
	 KkAO4Cql9cMJLXpMa0g0EbkaGil+/s1j6TdGGz4k=
Date: Wed, 10 Apr 2024 10:25:26 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Jakub Kicinski <kuba@kernel.org>, linux-usb@vger.kernel.org,
	Li Yang <leoyang.li@nxp.com>, Zhang Wei <zw@zh-kernel.org>,
	kernel@pengutronix.de, netdev@vger.kernel.org,
	Shawn Guo <shawnguo@kernel.org>, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] MAINTAINERS: Drop Li Yang as their email address stopped
 working
Message-ID: <2024041010-neuron-vividness-8202@gregkh>
References: <20240405072042.697182-2-u.kleine-koenig@pengutronix.de>
 <20240409144204.00cc76ce@kernel.org>
 <u4bhjzjr4jjx26r3r4jupqd5u273xsvuyfzq5ecv6binoyoqzq@5zib23vgtlsx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <u4bhjzjr4jjx26r3r4jupqd5u273xsvuyfzq5ecv6binoyoqzq@5zib23vgtlsx>

On Wed, Apr 10, 2024 at 08:42:06AM +0200, Uwe Kleine-König wrote:
> On Tue, Apr 09, 2024 at 02:42:04PM -0700, Jakub Kicinski wrote:
> > On Fri,  5 Apr 2024 09:20:41 +0200 Uwe Kleine-König wrote:
> > > When sending a patch to (among others) Li Yang the nxp MTA replied that
> > > the address doesn't exist and so the mail couldn't be delivered. The
> > > error code was 550, so at least technically that's not a temporal issue.
> > > 
> > > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > 
> > FWIW it's eaac25d026a1 in net, thanks!
> 
> Greg also picked it up, it's fbdd90334a6205e8a99d0bc2dfc738ee438f00bc in
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-linus
> . Both are included in next-20240410. I guess that's not a big problem.
> (And please prevent that the patch is dropped from both trees as it's
> already included in the other :-)

We already got a report from linux-next about this, it's fine, we will
both keep it.

thanks,

greg k-h


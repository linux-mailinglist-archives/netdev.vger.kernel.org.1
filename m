Return-Path: <netdev+bounces-147866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A7B9DE8FE
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 15:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31416B21640
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 14:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D7F13B280;
	Fri, 29 Nov 2024 14:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yzQx5b75"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA7012C54B
	for <netdev@vger.kernel.org>; Fri, 29 Nov 2024 14:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732892131; cv=none; b=BSENGoHPW1DJRHGPwlXPxApVCbiJieZrbRSJ1Fmnf1vOvWT3nvlvShqaQKJkK5vMVbnFNPNecvVdphW9eRgYazh+ddL8xA4fgfYjvZY8flnFIaHl8mGI4h3nSASyDU0JY9mmbyJ4C0C0gSVx5pHMkRkDhT8ikP/PPiNHhWZQBvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732892131; c=relaxed/simple;
	bh=6D9bHYJhfcicOyo0h+wUK6p2bT4pC0YQsIiDuGkY0dE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Up/mi44kkhOVCT7EMUk+XlMr5uDPuoJhNmJ71qO59mdww6yr13fyoQs7oXQL6ODdIWR79NWhOKFxejL66rhfU8UNQjVILkIXsxrAfEfWwg/LQD1Yi+1nCZoBGS/N+hhI3A9E90T5DeVhOznSuOMuDTpUfH6FEzI7I2VjuzjAZJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=yzQx5b75; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=Z/MUXJ13C4OYGPKgYFEyHTZYYNTEtrQwRAdBo6EEdLg=; b=yz
	Qx5b75kH3DcHHbrzVh+BEaVxSU19QPKkXLHiH5Bau/fpwAmAGi3JfRpyeMEy97T139Qchk3Xojpx9
	Bpp+E3GaHob9pbHRezWM9DCz3JU9ZKMtbOBAP6ORXlAgiiRceJl9Brzg/HgFyXkaywpYJKe+p2MBU
	/Ji/CuL9UjpIG9I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tH2Oz-00EmG3-Sf; Fri, 29 Nov 2024 15:55:25 +0100
Date: Fri, 29 Nov 2024 15:55:25 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Michal Kubecek <mkubecek@suse.cz>, kernel@pengutronix.de,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2] ethtool: add support for
 ETHTOOL_A_CABLE_FAULT_LENGTH_SRC and ETHTOOL_A_CABLE_RESULT_SRC
Message-ID: <3774dd61-6074-4cd9-97e0-aab7a275f428@lunn.ch>
References: <20241128090111.1974482-1-o.rempel@pengutronix.de>
 <919a9842-f719-41ac-96fb-ae24d2f0798f@lunn.ch>
 <eajj4mhvqkwrl7lmsrmjy32sncanymqefhxkv4cpnjvxnf2v7o@o6vtfpu7pyym>
 <9d8b7d97-75b8-4e39-91c5-dd56b157ce84@lunn.ch>
 <Z0lbGyg99mNN4V7L@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z0lbGyg99mNN4V7L@pengutronix.de>

On Fri, Nov 29, 2024 at 07:11:39AM +0100, Oleksij Rempel wrote:
> On Thu, Nov 28, 2024 at 06:41:11PM +0100, Andrew Lunn wrote:
> > > > ETHTOOL_A_CABLE_RESULT_SRC is a new property, so only newer kernels
> > > > will report it. I think you need an
> > > > if (tb[ETHTOOL_A_CABLE_RESULT_SRC]) here, and anywhere else you look for
> > > > this property?
> > > 
> > > Looks like a forgotten edit of copy&pasted text
> > 
> > Duh! Yes, i did forget.
> 
> Arrr... i check existence of wrong field...  (-‸ლ)

We all failed the copy/paste test :-(

	Andrew


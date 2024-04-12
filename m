Return-Path: <netdev+bounces-87314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0BB8A2838
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 09:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 118DBB250F6
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 07:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961DA4C3C3;
	Fri, 12 Apr 2024 07:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onvtjk2M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBFA4AEE3;
	Fri, 12 Apr 2024 07:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712907332; cv=none; b=mFHZsh2z728xB5vG+IA2opKF2Z8Am6V8eEcbylzEwObopnMKYZZ5hdSNmpkAEwUc+H2yN5Br/43gZllbf6wUuCu1EltYrHMQDDXWozBm8EhGwKJkSRRzn/jhggI3mqkYWv/I0rCRtUT8EAid7l1aYSIUKJgmi+TdJr5XpCFEvUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712907332; c=relaxed/simple;
	bh=aBqeB6EhAMZE55o62wkswbIYp1v19KKMYxDndp/Zfos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ceYlrKBdcCSQM8+rwyDhzklbW1O4DaPoawwGPxejQG/bgfnAFYM5fQ9vGV6Ornceed/SWp37zvAzWp0H0ljQ+XFHecLT0s0P9OQRSCHj9r5TFmjfkSPtpLFK0InUsvYhK/2QYDHM0s7Q5AfPV65Vw+AtsZAh76KtqeN6H9BmQXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=onvtjk2M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE619C113CC;
	Fri, 12 Apr 2024 07:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712907332;
	bh=aBqeB6EhAMZE55o62wkswbIYp1v19KKMYxDndp/Zfos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=onvtjk2M1GmmRrVp72ghMuzM2PxtTfE8SaDoMzzvj5LE8xMbampt9s/yw9lbe1vHH
	 UmM+oAhHhWFPyqX8gR0GXUxo5tCw7PG4yYRH/lsxvFkdo8hQXbiBvmvPOHSC2Xvj8o
	 9k/7m0+n/JoVGACp0ryqwoEr6OlpUHCnEe0lSvgHx0S6kby9FoP2f8Q6NPtniYka4A
	 Ep5r7Tdnc/hHfPjJl3d8qwv0CpJceyU/wNEwMw+Nwwtw0Ra/ni9sWymUKoBpbh9Aop
	 vgwBOS/Kl0AtatgdrteyO5JN8ycrO6AYq/HmA8R2u6TWTm0G6wdN4OprvjJ3gF9F8j
	 tAQzV9YH6O9TA==
Date: Fri, 12 Apr 2024 08:35:27 +0100
From: Lee Jones <lee@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Min Li <lnimi@hotmail.com>, richardcochran@gmail.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Min Li <min.li.xe@renesas.com>
Subject: Re: [PATCH net-next v2 1/1] ptp: 82p33: move register definitions
 out of ptp folder
Message-ID: <20240412073527.GO2399047@google.com>
References: <LV3P220MB12026EB15790ABE932799E53A0062@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>
 <20240411163240.GI2399047@google.com>
 <20240411185517.153a7dff@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240411185517.153a7dff@kernel.org>

On Thu, 11 Apr 2024, Jakub Kicinski wrote:

> On Thu, 11 Apr 2024 17:32:40 +0100 Lee Jones wrote:
> > > From: Min Li <min.li.xe@renesas.com>
> > > 
> > > Relocate idt82p33 register definitions so that other multi-functional
> > > devices can access those definitions.
> 
> What I was asking for was to mention the other drivers which will make
> use of the header _in the future_.
> 
> Really, it'd be best if the patch was part of a patchset which adds
> a driver that needs it...

100%

> > > Signed-off-by: Min Li <min.li.xe@renesas.com>
> > > ---
> > > Submit to net-next and add driver name suggested by Jakub
> > > 
> > >  drivers/ptp/ptp_idt82p33.h       | 27 -----------------------
> > >  include/linux/mfd/idt82p33_reg.h | 38 +++++++++++++++++++++++++++++---  
> > 
> > Why does this need to go into net-next?
> 
> No preference here, FWIW

-- 
Lee Jones [李琼斯]


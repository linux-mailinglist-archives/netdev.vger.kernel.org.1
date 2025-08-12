Return-Path: <netdev+bounces-212980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD6AB22B83
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 17:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A93334E20D0
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 15:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C90D23B610;
	Tue, 12 Aug 2025 15:17:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E21232C85;
	Tue, 12 Aug 2025 15:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755011822; cv=none; b=a3GiuYaF7Y+Ix3dHUhh6b6Ue+/9ZUKGdEzYFWPvZmTxy5oE8/AAYbnsg4x723TtFQ3SsIZLX9LCl4HlM3ts1WIgWs7wYbNKhbJ05QPaGbGubPP2yhSYqUhw2JPUzLK2j5003B+X2JZmcM2LHi4Y/MZp+t4asWTAgk/gpQHebEt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755011822; c=relaxed/simple;
	bh=wzsXv0fgM+TwJJ0/7xW+Ia503PFFwELDRUWjXPmE6EE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hAjSFWGNVKGSrhI6dQU0ett6BMhJd9CC/PI08a0nsVr3kePL31PmLjPNntTwLMYU7q/uqolQDSYkhj2e2APFKOn/ITulBkxTZ9ZgdT+riDtB2mK6jSz8z+ywHcLSeehZHO0YnKjaqSsgkXqq992jkjoHzkxDfRdAPa5+zYM1YtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1ulqkD-000000000mQ-1ZF5;
	Tue, 12 Aug 2025 15:16:57 +0000
Date: Tue, 12 Aug 2025 16:16:53 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev-driver-reviewers@vger.kernel.org, netdev@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Russell King <linux@armlinux.org.uk>,
	Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [ANN] netdev call - Aug 12th
Message-ID: <aJta5YNhKM9OqEmg@pidgin.makrotopia.org>
References: <20250812075510.3eacb700@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812075510.3eacb700@kernel.org>

On Tue, Aug 12, 2025 at 07:55:10AM -0700, Jakub Kicinski wrote:
> Hi!
> 
> The bi-weekly call is scheduled for tomorrow at 8:30 am (PT) / 
> 5:30 pm (~EU), at https://bbb.lwn.net/rooms/ldm-chf-zxx-we7/join
> 
> Sorry for the late announcement, I got out of the habit of sending
> these. Luckily Daniel pinged.
> 
> Daniel do you think it still makes sense to talk about the PCS driver,
> or did folks assume the that call is not happning?

It could make sense to talk about it, but maybe we talk about other
topics first to Sean can join us as well. However, I think mostly we
depend on Russell or someone else to make a decision in terms of how the
three of us (Christian, Sean and I) should continue.



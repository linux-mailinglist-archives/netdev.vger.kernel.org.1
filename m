Return-Path: <netdev+bounces-139090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EFC9B0200
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 14:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C1DC283DB6
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 12:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8F02038BC;
	Fri, 25 Oct 2024 12:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCun5sFm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77BF2003DE
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 12:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729858679; cv=none; b=iORSnQM6M3/lsx5639zy3folrc2tfYwL2ec245jK0WvIOBtukelyH/Dc8sEehtfV3IbxgoatLzmR4DtgIe2ZrOXX+3SWkYzkXH99GC1Cfx1fCNKS5fwOYSLqy2TSvvwirWGBUmt+7ExTmNpaYb5KV4izddIqEcncMyxZIdD7aXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729858679; c=relaxed/simple;
	bh=jCq2kvNNhmnubHGrbsxbe+9QWbXZy9i9e5WuBbJZxvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jMEkCAcd5/9CVWXTHdvDisYdLV4GnaJP0nnPEiOYpZDWBpboVQ1aXJHc3hn1epIgSuBbP2CpBcXhxhFQ9DjvLRlouVwyt96hpsjutMzR6nPm2WdVNsC63oq5jlAcfuOxN+gET/Cc8+jPRiD4B3bHa7k5M/LK28omH5VjQ3PREHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCun5sFm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E9DC4CEE4;
	Fri, 25 Oct 2024 12:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729858679;
	bh=jCq2kvNNhmnubHGrbsxbe+9QWbXZy9i9e5WuBbJZxvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CCun5sFm6/qOm5uD1Kknv4FOg3VtrF/ro1a3ktYG/oz2yYkLM+mvJf5l+h1K3iN+E
	 ItBg3eK0c6W6doLARHRgAWe3mPSqlPGy/2YhaWv3r+OjDycjca8lpeUE4vhLJCrnuP
	 5agCqe9wEhIVKASo+OZU9uz1ZSld6UxyjsqbcuEvW8FWUbBSZjeDQ+LjKtXY442WvD
	 j0Ef5R/9RCf10VtrrcFFUuoyp41LZ3qys0+KheLne4liOooW80+VBk8cGTHdAItRrf
	 1wT0e7Q5tELZkDFKzndelO8FqwMSeT+Gk4jSGQ0FZuCfaZQhgS8M5am41hQHmDljGg
	 q9XnXqBV7kMfw==
Date: Fri, 25 Oct 2024 13:17:55 +0100
From: Simon Horman <horms@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] r8169: add support for RTL8125D
Message-ID: <20241025121755.GR1202098@kernel.org>
References: <d0306912-e88e-4c25-8b5d-545ae8834c0c@gmail.com>
 <20241025112523.GO1202098@kernel.org>
 <9fece96e-9a38-4b97-93d9-885a5d8800cc@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fece96e-9a38-4b97-93d9-885a5d8800cc@gmail.com>

On Fri, Oct 25, 2024 at 01:44:48PM +0200, Heiner Kallweit wrote:
> On 25.10.2024 13:25, Simon Horman wrote:
> > On Thu, Oct 24, 2024 at 10:42:33PM +0200, Heiner Kallweit wrote:
> >> This adds support for new chip version RTL8125D, which can be found on
> >> boards like Gigabyte X870E AORUS ELITE WIFI7. Firmware rtl8125d-1.fw
> >> for this chip version is available in linux-firmware already.
> >>
> >> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> > 
> > Reviewed-by: Simon Horman <horms@kernel.org>
> > 
> > ...
> > 
> >> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> > 
> > ...
> > 
> >> @@ -3872,6 +3873,12 @@ static void rtl_hw_start_8125b(struct rtl8169_private *tp)
> >>  	rtl_hw_start_8125_common(tp);
> >>  }
> >>  
> >> +static void rtl_hw_start_8125d(struct rtl8169_private *tp)
> >> +{
> >> +	rtl_set_def_aspm_entry_latency(tp);
> >> +	rtl_hw_start_8125_common(tp);
> >> +}
> >> +
> >>  static void rtl_hw_start_8126a(struct rtl8169_private *tp)
> > 
> > Maybe as a follow-up, rtl_hw_start_8125d and rtl_hw_start_8126a could
> > be consolidated. They seem to be the same.
> > 
> Thanks for the review. Yes, for now they are the same. Both chip versions are new
> and once there are enough users, I wouldn't be surprised if we need version-specific
> tweaks to work around compatibility issues on certain systems.
> Therefore the separate versions for the time being.

Thanks, understood.


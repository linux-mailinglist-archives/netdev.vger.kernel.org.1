Return-Path: <netdev+bounces-73605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D54C85D5AE
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 11:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2B2AB219BE
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 10:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E575231;
	Wed, 21 Feb 2024 10:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJUa3/J8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11888443F
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 10:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708511730; cv=none; b=YRCQvLBfWeHatXMB7GNcWn2yr9I8Oz37ruvuGPAJQwXXuJekBf66WGzAp9Tqg7iUeoDAVEb3FFXLpfgAeKA8jGviVZU6Msb7fEA7Jt4G9YvijJy/IlBPjFwVSP8j3/wiQSbyZS98zYgKk8kOkGbenE4mMIEmXXDab9d3vYv89qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708511730; c=relaxed/simple;
	bh=mhJpWUQj49VExZo/egSI7ARpDJ9XVpQJjU1eFfu6WAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vw+esVkIoyzYYdMUh/u86vn1CFcJHBC7n0vcwQsOxPR2Y6evUjUDrfNAS/Kvh1O/fHbcR2mYLwfft7pYJXfcFpqA1kY/aKnaEnXhcZd2PVkBjJCgQZtUkwg0I75hNWMt5Y16C+oj9rph0ZIB6O/7DCf4S0TkooTMFDUoHdD7IuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJUa3/J8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE0FC43390;
	Wed, 21 Feb 2024 10:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708511729;
	bh=mhJpWUQj49VExZo/egSI7ARpDJ9XVpQJjU1eFfu6WAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OJUa3/J8MGAw6s4WTgXenUe7troxj1F/WNCxCchzoxeb5OXJbU7BgvcPyGsW1sR1X
	 t3MtP5CB6e/WMXqcC2vm5r2Zg/uLpglGoQ68O5PLuHhTvGc+l5UxKmYlYA5TCvGuHJ
	 81heOE4e+F3sE3DfyVlE5/WN0yLxdjLRDx/2vvHqfZPVSBw4gyZMChSbtpfUf2xOQN
	 Eohb+HESWUg8ptcxLpnT/0EVtstZlzBP/6wavP67QMH03rD1n3U6C2E/W9lpFuKtNS
	 vM41aRE7R+3C6f4W5WUoNzyKOCPZ75JTAqcS/VhLjT6DdVddeu7xlNITsbf9vV1TTl
	 tHUy7DiXxs1iA==
Date: Wed, 21 Feb 2024 10:35:25 +0000
From: Simon Horman <horms@kernel.org>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Alan Brady <alan.brady@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH iwl-next v1 1/2] igb: simplify pci ops declaration
Message-ID: <20240221103525.GC352018@kernel.org>
References: <20240210220109.3179408-1-jesse.brandeburg@intel.com>
 <20240210220109.3179408-2-jesse.brandeburg@intel.com>
 <20240219091542.GS40273@kernel.org>
 <823fdfe2-7c8c-4440-bc6a-3896c542f0e4@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <823fdfe2-7c8c-4440-bc6a-3896c542f0e4@intel.com>

On Tue, Feb 20, 2024 at 08:48:28AM -0800, Jesse Brandeburg wrote:
> On 2/19/2024 1:15 AM, Simon Horman wrote:
> > On Sat, Feb 10, 2024 at 02:01:08PM -0800, Jesse Brandeburg wrote:
> >> The igb driver was pre-declaring tons of functions just so that it could
> >> have an early declaration of the pci_driver struct.
> >>
> >> Delete a bunch of the declarations and move the struct to the bottom of the
> >> file, after all the functions are declared.
> >>
> >> Reviewed-by: Alan Brady <alan.brady@intel.com>
> >> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> >> -	.probe    = igb_probe,
> >> -	.remove   = igb_remove,
> >> -#ifdef CONFIG_PM
> >> -	.driver.pm = &igb_pm_ops,
> >> -#endif
> >> -	.shutdown = igb_shutdown,
> 
> 
> >> +	.probe    = igb_probe,
> >> +	.remove   = igb_remove,
> >> +	.driver.pm = &igb_pm_ops,
> > 
> > Hi Jesse,
> > 
> > the line above causes a build failure if CONFIG_PM is not set.
> 
> Hi Simon, thanks!
> 
> Yeah I missed that, but do we care since patch 2/2 then fixes it?

Right. TBH I wrote the above before noticing 2/2.
And I guess it is not a big deal either way.


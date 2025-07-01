Return-Path: <netdev+bounces-203027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 044F8AF0322
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 20:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 206324A47D9
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 18:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612AC23AB8B;
	Tue,  1 Jul 2025 18:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pOvklq/1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A423596B;
	Tue,  1 Jul 2025 18:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751395719; cv=none; b=py6r3RmrkJo06OTIy4EjUZ9BMCfj2+RUeZvEaHXLF4ZpVleZOeOGChYk3ryWarBCylVsgmNONJOLICRb4rcpqQ1a9l9VkKAmOLx6eGeffqyQcQYGfy9RvJlRRDZrYw1/Rdyjwosziw+xWX5xU89dMLH6cBqgl7T4DEMoDbRLyCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751395719; c=relaxed/simple;
	bh=HEEXBU9qP4L+nB3hLofAs922j52oKkWZO5GGHgXNrJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQp0F4vtk0gczqM4ihNVx35EJADAldfmi/GSxzWvgSwhJQEb5wrpKTip4UEF56UYoQxxv1Blico4RNc9XDyK879d+0DyHITMIXRL0Jygfy8NeWw0lGWab3yFcgH8VpT6WavyVHMnYkC5wEPGkQF7hmpEjtYhdzlnMWjrJ95FQGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pOvklq/1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A42C4CEEB;
	Tue,  1 Jul 2025 18:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751395718;
	bh=HEEXBU9qP4L+nB3hLofAs922j52oKkWZO5GGHgXNrJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pOvklq/1jSsvsxqOZCvcrpnrtBB5ZzEViZPcegr+WxMeJk883Aun/2Kd5aYayHlsn
	 E6r4pUDpc2HEUI58zaMByFOwCovXs8O2sp49hSziFU08Sfn8vt81yM0RZEpFhpYSmQ
	 rtak/Xa2d6tybGKAznzauS0M/b3yQKo9wlGD30Vxkz5y3X4latr1Yd69+6pQrVhTvq
	 onz+rWgPWn9R6WUKjheG5lZ88iu+XZ4SWRYnSZCZW9ZcfxVJG7jmohEwqZDKvRXA8T
	 ttKFgjmtvKJdo4VkbiA7sPlR8Tb1KBeSMpk5oQlA4jGTBuhC9LptFAd0/vrQWS2XD+
	 XQxgsQACWo5FA==
Date: Tue, 1 Jul 2025 19:48:34 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org,
	andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, johannes@sipsolutions.net, kuni1840@gmail.com,
	willemb@google.com, Todd Benzies <tbenzies@linuxfoundation.org>
Subject: Re: [ANN] netdev foundation
Message-ID: <20250701184834.GA172361@horms.kernel.org>
References: <20250701103149.4fe7aff3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701103149.4fe7aff3@kernel.org>

On Tue, Jul 01, 2025 at 10:31:49AM -0700, Jakub Kicinski wrote:
> Hi!
> 
> We are pleased to announce that we have formed a foundation (under
> the auspices of Linux Foundation) to pay the bills for various systems
> which grew around netdev. The initial motivation was to move the NIPA
> testing outside of Meta, so that more people can help and contribute.
> But there should be sufficient budget to sponsor more projects.
> 
> We set up a GitHub repo to track proposed projects:
> 
>   https://github.com/linux-netdev/foundation
> 
> The README page provides more information about the scope, and
> the process. We don't want to repeat all that information - please
> refer to the README and feel free to comment or ask any questions here.
> 
> And please feel free to suggest projects!

To follow-up on Jakub's announcement:

As part of the process of establishing a lab for CI the TSC is looking for
suppliers for HW hosting and (optionally) CI contracting services. So if
anyone has contacts and so on to this end please feel more than welcome to
contact Jakub and myself who are coordinating this activity within the TSC.

  - Netdev Foundation TSC


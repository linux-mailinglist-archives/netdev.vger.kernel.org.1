Return-Path: <netdev+bounces-133698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E825996B96
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 15:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 562C81F22A78
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 13:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CE019340C;
	Wed,  9 Oct 2024 13:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jEj1ZiN/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EBF192B70
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 13:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728479824; cv=none; b=Ius6o8lQe0E6UfKFD1hLsGMs5UqEx11BSI8CzWKVmi1PwEFMvzbV/yjSfx3XefGcTsFNVvie8A6V5GD7+nUEQioX2D+IsXNpZHESvOS+s7jkvzSVYm286LAe5pE7hUaLNcf4/OE2dBMFQJ8KvcGdxrx+v2qHkEJmPUJYpz7JwFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728479824; c=relaxed/simple;
	bh=M77GgGu8SmnXrQ8ahTNMqXxC531YNHUEEJJiDbALg1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ChSGpZt3+CT6KB7LPQK1VZmU35b0fnbOrZvVAhSx/vbwa2PKHzmJGDdGaiN2XyqBIrSHmvT6MoHD7kjdcTBPAwfn92IMgxDYgfHGetzLG1TaP3c/byfUr1eOu03L1PwMKOLl6JaocOQga8tQBgT5KtiF3DwJTjYQjsQ/W/Zd8c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jEj1ZiN/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F0B4C4CECD;
	Wed,  9 Oct 2024 13:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728479824;
	bh=M77GgGu8SmnXrQ8ahTNMqXxC531YNHUEEJJiDbALg1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jEj1ZiN/Ynj6/jhM9TXLcRnTCYdrTLcA3Th5qHceu8Ks4jmkTOtVI7iqngjqrfFKe
	 SfUvWyhu+CybATXWHqYvy6c9F9VSIShn0n54iRzaLzU7E0ykUJqYeEnWnr2afDomY2
	 6bJnp/pEoYymNux4ZdjvDLTkoQ+AEnN7teZlBZv5feQg7FYNRTuI3EfrfH0Ewm48b9
	 uRNm1qZBGM/mu2yWc5w+e6ra+8hPUTIh5snU09lLyuLt1aMDKI2Y09FOBicBfLkr0W
	 C7NgC5fJYlATO5fQLDqd9I8uaEvWT30e7vbMTnrNjekt8MLcpZw4L0wx0YVo7XBMVY
	 GJhEMk8CwPWPg==
Date: Wed, 9 Oct 2024 14:17:00 +0100
From: Simon Horman <horms@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] r8169: remove original workaround for RTL8125
 broken rx issue
Message-ID: <20241009131700.GX99782@kernel.org>
References: <382d8c88-cbce-400f-ad62-fda0181c7e38@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <382d8c88-cbce-400f-ad62-fda0181c7e38@gmail.com>

On Wed, Oct 09, 2024 at 07:48:05AM +0200, Heiner Kallweit wrote:
> Now that we have b9c7ac4fe22c ("r8169: disable ALDPS per default for
> RTL8125"), the first attempt to fix the issue shouldn't be needed
> any longer. So let's effectively revert 621735f59064 ("r8169: fix
> rare issue with broken rx after link-down on RTL8125") and see
> whether anybody complains.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


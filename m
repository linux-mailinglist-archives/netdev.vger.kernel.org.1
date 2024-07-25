Return-Path: <netdev+bounces-113072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB32093C943
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 22:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85405282C3F
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 20:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D8B4779D;
	Thu, 25 Jul 2024 20:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLZZI2pi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3C93A8C0;
	Thu, 25 Jul 2024 20:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721937708; cv=none; b=KaDI6OnlAWyjzaHogHMIiaeNv82vOiB4uovszmLGkH1A4B0DEf/4zH19EuLDAnjxRfNmk68h90jwK4To4rHaXghhyftywzgV2uePN0WWthGQkfsr4RhzCOhVKvtUQKPNpp5O+7lkr6S3ShtE+P7cgRPim2k0BfvH1Zz0MTmO5g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721937708; c=relaxed/simple;
	bh=S4YLwFo1Xpgy87t4jbnIqhIKlr97surhtYd896uaa58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TSbaMFFz/GW31PZkY63b3iPRZzPz+Ve6MAl7WFkBnESgAlNAE6HO1kLf1+2PLamzbCHkqfHRKdM96kya+Rpm49FP1oEybmpxSco2v1eoDlhaSCp+qkwLXK3Eapb96M3E0SWKnR/3dSwckFjNAjey51YAdYIFthQ2KsQa2HDmGOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLZZI2pi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C97F6C116B1;
	Thu, 25 Jul 2024 20:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721937707;
	bh=S4YLwFo1Xpgy87t4jbnIqhIKlr97surhtYd896uaa58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QLZZI2piJPIqEMQuKsNePfgr4JUPfDbd1AwZ9NczBgensSqv8Hi1ySY66XcD1v+9h
	 et08zFPQH3+pjRRTDnT4pMkTrhqBZXh0rMFZzFeIaV16jMPuXs64wsdgERDy0aDBEf
	 cqJXWrqRZOYV+UG4SlFaTBNq5IxJQJDn+3oe4zqXJ/quNKidrqb8xLWisw2uxFDVOj
	 Rk0o+of3xG29/XIwiKVDpHwb9Y+f6ifLGgOERopK2yQgenANw+ltJphdD1qtkuPuIy
	 HiWdtJk9xo6xQmD3xCrW+VGU8fl9x4kL3Ij49XstPWeHLr0ELKHjkFlrLOi4Jghj3D
	 9hOycJlK/JUdg==
Date: Thu, 25 Jul 2024 21:01:43 +0100
From: Simon Horman <horms@kernel.org>
To: Mark Mentovai <mark@mentovai.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Russell Senior <russell@personaltelco.net>,
	=?utf-8?B?TMOzcsOhbmQgSG9ydsOhdGg=?= <lorand.horvath82@gmail.com>,
	Mieczyslaw Nalewaj <namiltd@yahoo.com>,
	Shiji Yang <yangshiji66@outlook.com>
Subject: Re: [PATCH] net: phy: realtek: add support for RTL8366S Gigabit PHY
Message-ID: <20240725200143.GM97837@kernel.org>
References: <20240725170519.43401-1-mark@mentovai.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725170519.43401-1-mark@mentovai.com>

On Thu, Jul 25, 2024 at 01:05:19PM -0400, Mark Mentovai wrote:
> The PHY built in to the Realtek RTL8366S switch controller was
> previously supported by genphy_driver. This PHY does not implement MMD
> operations. Since 9b01c885be36 (2023-02-13, in 6.3), MMD register reads
> have been made during phy_probe to determine EEE support. For
> genphy_driver, these reads are transformed into 802.3 annex 22D clause
> 45-over-clause 22 mmd_phy_indirect operations that perform MII register
> writes to MII_MMD_CTRL and MII_MMD_DATA. This overwrites those two MII
> registers, which on this PHY are reserved and have another function,
> rendering the PHY unusable while so configured.
> 
> Proper support for this PHY is restored by providing a phy_driver that
> declares MMD operations as unsupported by using the helper functions
> provided for that purpose, while remaining otherwise identical to
> genphy_driver.
> 
> Fixes: 9b01c885be36 ("net: phy: c22: migrate to genphy_c45_write_eee_adv()")
> Fixes: https://github.com/openwrt/openwrt/issues/15981

nit: AFAIK, the line immediately above is not a correct use of the Fixes
     tag. I think Link or Closes would be appropriate instead.

> Link: https://github.com/openwrt/openwrt/issues/15739
> Reported-by: Russell Senior <russell@personaltelco.net>
> Signed-off-by: Mark Mentovai <mark@mentovai.com>

Also, as a fix, this should be targeted at the net tree.

	Subject: [PATCH net] ...

Please see https://docs.kernel.org/process/maintainer-netdev.html


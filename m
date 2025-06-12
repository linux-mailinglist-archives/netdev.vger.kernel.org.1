Return-Path: <netdev+bounces-196884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DA4AD6C76
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 11:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE0F17AE232
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 09:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E490122D4FF;
	Thu, 12 Jun 2025 09:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+JGlX0L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A1622D4F2
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 09:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749721358; cv=none; b=I7D5IAu7cgpCyOAn0HqO0XHNhXTqPyJEnQepoUvwdxO003VtLT9dG4oHIoPX+rt0h7z1Ih2S2hCcMjFaaXIerlwezTB6wQFlRx8V9jlhTNlaJ/DR3V3a6vLTqA07VeJip+6I0pYch1nB2xtaHwab4ss4/BHKSaUtdexQC0fw9Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749721358; c=relaxed/simple;
	bh=z+GmqTrgC4P5FGA+uwRIJhwpiGmJpc53YGnN43NwP38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZQWkG5D31gaVucMPqQ3EEH6xP8b3guy8NDD5uRNkFUSWwlUDPz0xh3Nv30SEfBwD+MZxXYkLC/Rr7mKgW2dWCNlSCA1QjG+aE6SxHPMj0AHFcwVhghqMcKH7O9GzH60d6QdFUTjuiglXgOBwh5AdTHI3FVoUlxiZ+33DIXXkzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+JGlX0L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D57C3C4CEEA;
	Thu, 12 Jun 2025 09:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749721358;
	bh=z+GmqTrgC4P5FGA+uwRIJhwpiGmJpc53YGnN43NwP38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q+JGlX0L2eXgnsGPiwZaDGHJjcjwZBMAM8OKD8ucn+jl8SvCOHr2kGBbWCz0w2L+2
	 jYlnDZwROQXJFBQY5X3fRedHNyXaB6j07pUZPIL35WySlS8ieeuxDtVzqLlfVTwOW0
	 1oRaE12IP0XppM/+UNOR44I7BQet8a5QY++ChRuz0Pq3+h2flhot1kGHEEZy133rzP
	 HR+RqO2+Kiina6Zw1hP/6gdmCRR8QaiF9VUOjrdeTlNO6VEu8q37Vq3gVoC8wSsBrO
	 /NHX0L9/yrx2xWnOBhyZY+N0p1D6dHXf9GNXQDVS51AmjeCfUnZR8a1NTo+nP3L4F/
	 935Ku3aq7RWWA==
Date: Thu, 12 Jun 2025 12:42:34 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, linux@armlinux.org.uk, hkallweit1@gmail.com,
	andrew@lunn.ch, davem@davemloft.net, pabeni@redhat.com,
	kuba@kernel.org, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [net-next PATCH 0/6] Add support for 25G, 50G, and 100G to fbnic
Message-ID: <20250612094234.GA436744@unreal>
References: <174956639588.2686723.10994827055234129182.stgit@ahduyck-xeon-server.home.arpa>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174956639588.2686723.10994827055234129182.stgit@ahduyck-xeon-server.home.arpa>

On Tue, Jun 10, 2025 at 07:51:08AM -0700, Alexander Duyck wrote:
> The fbnic driver up till now had avoided actually reporting link as the
> phylink setup only supported up to 40G configurations. This changeset is
> meant to start addressing that by adding support for 50G and 100G interface
> types as well as the 200GBASE-CR4 media type which we can run them over.
> 
> With that basic support added fbnic can then set those types based on the
> EEPROM configuration provided by the firmware and then report those speeds
> out using the information provided via the phylink call for getting the
> link ksettings. This provides the basic MAC support and enables supporting
> the speeds as well as configuring flow control.
> 
> After this I plan to add support for a PHY that will represent the SerDes
> PHY being used to manage the link as we need a way to indicate link
> training into phylink to prevent link flaps on the PCS while the SerDes is
> in training, and then after that I will look at rolling support for our
> PCS/PMA into the XPCS driver.

<...>

> Alexander Duyck (6):
>       net: phy: Add interface types for 50G and 100G

<...>

>  drivers/net/phy/phy-core.c                    |   3 +
>  drivers/net/phy/phy_caps.c                    |   9 ++
>  drivers/net/phy/phylink.c                     |  13 ++
>  drivers/net/phy/sfp-bus.c                     |  22 +++
>  include/linux/phy.h                           |  12 ++
>  include/linux/sfp.h                           |   1 +
>  14 files changed, 257 insertions(+), 88 deletions(-)

when the fbnic was proposed for merge, the overall agreement was that
this driver is ok as long as no-core changes will be required for this
driver to work and now, year later, such changes are proposed here.

https://lore.kernel.org/netdev/ZhZC1kKMCKRvgIhd@nanopsycho/

Thanks

> 
> --
> 
> 


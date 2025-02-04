Return-Path: <netdev+bounces-162476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8549EA27023
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 12:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E2B23A82A6
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 11:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B72720C02A;
	Tue,  4 Feb 2025 11:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YeBg5ove"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0AD20ADD6
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 11:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738668058; cv=none; b=jYZUV3sXPQIMSP4J/U2RMmbZ/azihX4sQeZJM12w682+1wapzUHmXpkdvcKUjkOKhGm+QIMm2u6VkZkDaur8kFT8NCHEeC8R4kcySf7q4y09WmwRYBU0bxfiH0pPCUh4TneFhc661qPMOG/eKLphvwRDYPmFN5BcMRgeptqzC24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738668058; c=relaxed/simple;
	bh=3QOSC1kW1NDfuE8YANuZmlIS/ctvf1oOaTY6JZ54DO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ROFZKFxE5VWDmXgVNDQdRHvh0ZYPhj+5loGYsJGdhoPEuIJGncl9W28H9WZviUH22uwqNsdP8VojqHmy119xruIty5iV5yl55LisWY1WO3aTnpBlG18dYf0UrhGWJ/QZxhQ4JV0sujpU1lgFjPulrUEuYWx3u6pLQBf/kt7q4fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YeBg5ove; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAE40C4CEDF;
	Tue,  4 Feb 2025 11:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738668058;
	bh=3QOSC1kW1NDfuE8YANuZmlIS/ctvf1oOaTY6JZ54DO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YeBg5ovez7ciY2NCB1+jC9LxWj3b4VcHqgNALLJz9FOPutUmlp3mWHgUTAEnaeh0b
	 K6TBnqqRL06XZJ/PIGv5Jf0PrV6mtc4sxmYcRkAuNF1UAGJ0qDyyqWw6lR9SwsZdhI
	 S+TNWzhI175gb4kfU8s0zUPBCg7Ru6XKMrHjykPXx4Pdgp1P2e3bFoiEx9uSZ4SEnG
	 xlK1lLMGEihULtcbGQuSqU88iQfRW6f1sysFEPtLGh/7+KmEOf7Dn+g7na2vUA75me
	 6O42E9ZQjlOc9GZSkk4nvm+4XAVQ62j40aNXSwmzLcJZca+NzMoes4leXtrDtR+/ZC
	 MQoAyPWCvXPLw==
Date: Tue, 4 Feb 2025 11:20:54 +0000
From: Simon Horman <horms@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] r8169: make Kconfig option for LED support
 user-visible
Message-ID: <20250204112054.GS234677@kernel.org>
References: <d29f0cdb-32bf-435f-b59d-dc96bca1e3ab@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d29f0cdb-32bf-435f-b59d-dc96bca1e3ab@gmail.com>

On Mon, Feb 03, 2025 at 09:35:24PM +0100, Heiner Kallweit wrote:
> Make config option R8169_LEDS user-visible, so that users can remove
> support if not needed.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>



Return-Path: <netdev+bounces-184819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9AAA974FF
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 20:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CDBA189FAE1
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 18:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C891828541A;
	Tue, 22 Apr 2025 18:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uWrhhvT/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A353838382
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 18:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745348290; cv=none; b=leQKa1uU8tkPVznFu7JA/ChnsXtrgeiOEvzMchw+aKybdvSkwkK7ezGb45M/L9xUj1QYRuyhwNJKA8+w7iPl647PxvxIeeKM1UwBAF4DxtQcDRSOoO+ftlaeTRSOsq6tEOuQER1/fFG6kupp6n55t3wKjRb6KsDiwR0Q6w8mR+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745348290; c=relaxed/simple;
	bh=p7AkfJTAsxh2LzSasm+A/6Jwqk6Ibo+H9/B36bII/mU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K0WY7d/TNTEVw1dI9MluSCW1E4CppZYyvAjcuOoSEME0hSGhGbdVFj3qbyz9tsAjurq1qpEOafpRdGoj/1vfCyD62slXDw/wAJv7AzcFm426WLzDqltrrWTDhCWRBBi1dE8+b8lSf9o5p0er2ciNRJ2D3qSVSoVBhJ6KP8s7oO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uWrhhvT/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78903C4CEE9;
	Tue, 22 Apr 2025 18:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745348290;
	bh=p7AkfJTAsxh2LzSasm+A/6Jwqk6Ibo+H9/B36bII/mU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uWrhhvT/0T4bhF6TL5qJYwhLF+plfk9qULYFiDd5wjEp2/dwA1SxLnPMnUwevRxRU
	 6DV4jXO46SJY0tRy49AECaxn9Cx9bEepreVqjYZj3KIaJaIDqZsmJXE0UxsGKshF3P
	 rwsq5CjJRgMU/u4PEeDkeane368EHTlsxJS5JvHSLbcB3YJhBsyHTvFRp2xQ7LrcXH
	 BieqoExfMg4VAA71z/WY8SACVzs3y9eRBww2+WAaM+rGB6GLXTmom8MOoj7NnO2S9U
	 xe+enOhFCIMwHVa0GjcTN8058lPHk5itNBxqtpm86RqfHqYM5iUei7ByHueTnbxavB
	 hCa9a35HWdIIw==
Date: Tue, 22 Apr 2025 19:58:06 +0100
From: Simon Horman <horms@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 2/3] r8169: merge chip versions 64 and 65
 (RTL8125D)
Message-ID: <20250422185806.GP2843373@horms.kernel.org>
References: <5e1e14ea-d60f-4608-88eb-3104b6bbace8@gmail.com>
 <0baad123-c679-4154-923f-fdc12783e900@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0baad123-c679-4154-923f-fdc12783e900@gmail.com>

On Fri, Apr 18, 2025 at 11:24:30AM +0200, Heiner Kallweit wrote:
> Handling of both chip versions is the same, only difference is
> the firmware. So we can merge handling of both chip versions.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>



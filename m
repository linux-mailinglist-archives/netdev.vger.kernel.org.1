Return-Path: <netdev+bounces-243566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AB7CA3CC0
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 14:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F2453026AF5
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 13:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898E0333420;
	Thu,  4 Dec 2025 13:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMwJrJ9T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6445ADF6C
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 13:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764854496; cv=none; b=SHTg3QGpGsONY4bK3SVe6tT0yZVcTEBraoSNZUXI8QwyW4kJzSdOO6z65JwV2Tsx9W12iAoo1pQ7ZmjE9raLkb2zSsiI8QXSRpJksFIamzW4dABLHoyI29Dr/JstNXFUMSp6C7kdo2oNFOqqdjQPkeg2f7OWfGRxZ5eASC37Jso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764854496; c=relaxed/simple;
	bh=yyAVpr/quTaykg6lct63tKx4MzxALcP3Jwqqt9dI1LI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lg4utaNUHKPKLdHU2bvg36UDMrMqN3FsM5/N24NRayiUdsRT7gmepo1wWbO/VEkEyUnO77TyhWcN4iY9F3UqQrfM06Z5NMF/8L0RVXnch1edvrwcqzvShYhy6yRBwoS095jdKXP/xQYor2IKDD1HM/GJMhr6yvaV1ns+HhpTt5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMwJrJ9T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D14C4CEFB;
	Thu,  4 Dec 2025 13:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764854495;
	bh=yyAVpr/quTaykg6lct63tKx4MzxALcP3Jwqqt9dI1LI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BMwJrJ9TTJpnfLy51RfYcxD5ejaiDNpRgege+pEpkL4te4AyzKrs42oFwU0uybNsu
	 f0yNgcxw4uppzmdHNnmW/EQZIgYpSxY2nBDHecOw0QsIu1eF/1jEOjHOG6tUFU1jUU
	 DC2L/ovuRXnCQfSedlOYe7Sj4XK3zp1FLNyUvgD+QDQPrasKnpVpVHDlgAm6sDm/7q
	 EW3fJbUvMDW8GtcoWQdrATNKsqXDxgi4xq+KrTdALD+r6oVVyL5/2vVTu4ifAMQ5jY
	 V/6rREwx3AYyP4UIge4fqhnLWWcizXHsR8Uf9ivAKywbs+g3fPfazZT/PeiBzXJ+Wu
	 ykXVUjfFxp59w==
Date: Thu, 4 Dec 2025 13:21:31 +0000
From: Simon Horman <horms@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	adrian.pielech@intel.com,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Krzysztof Galazka <krzysztof.galazka@intel.com>
Subject: Re: [ANN] intel's netdev-ci
Message-ID: <aTGK25rhhwUinDqn@horms.kernel.org>
References: <a0561c1f-f64e-4d76-b08b-877897d45eae@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a0561c1f-f64e-4d76-b08b-877897d45eae@intel.com>

On Thu, Dec 04, 2025 at 01:59:34PM +0100, Przemek Kitszel wrote:
> Hi all!
> 
> I'm pleased to announce that we have set up infrastructure for testing
> netdev on our e810 NICs, with more to come.
> 
> Big thanks to Adrian Pielech who made substantial effort to make this
> possible and to Krzysztof Gałązka for the initial PoC work.
> 
> This work plugs into netdev-ci initiative by netdev maintainers,
> to run kselftests (mostly functional tests in python) against current
> proposed net-next branch, on real hardware.
> 
> Our results are here:
> https://netdev-ci-results.intel.com/ice-results/results.json
> 
> with a viewer for humans:
> https://netdev-ci-results.intel.com/

Thanks, this is very nice to see.


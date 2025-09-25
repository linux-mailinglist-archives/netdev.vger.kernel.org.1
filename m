Return-Path: <netdev+bounces-226142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66025B9CF5C
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 02:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A41401BC4591
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 00:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F7B2DAFAA;
	Thu, 25 Sep 2025 00:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eX/k7NYw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BAA2DA75B;
	Thu, 25 Sep 2025 00:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758761593; cv=none; b=N0KQfrgjebRru+vAIOOlgC4gc6TUCbtYEX/4ZRNgPrL0w1GUmuEIph/eZy/Fgog9pFpin2GbR6OAd5KZUNOUJ1xFR9Oo/ckJ/6CGkcdmvkV/3qoxDcruehHaoR77bHPdymTt9I/g73xwydFcGvQoDpEhDtBaVW8D+zeH6hVn4yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758761593; c=relaxed/simple;
	bh=2Ny85oVJGLDfq6wuTCeKDXi1t00R/7V7ikjaeUV33GA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OlWSz/pr+saqhlx9AZstR4DgTJjvVKbwmFWH2iUl1b35Oep0ely2IqGV2MHknsSlz+c7Fp5rF1azWWsMfQjZdsBEOFYnlMzARRktFmrxDjN+F0pSkM3vSaWGM9vsxUD7lv+LAsQasc7Tq0l4+veC91NnKtW5gMm8yrBR6adIZmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eX/k7NYw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29819C4CEE7;
	Thu, 25 Sep 2025 00:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758761592;
	bh=2Ny85oVJGLDfq6wuTCeKDXi1t00R/7V7ikjaeUV33GA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eX/k7NYwkJD2PXt9oCNo7jPVBEAUWCOH0RyU+3/9sBhm9bpj7m20aJr8CGYVL34yy
	 bvsbHlyzHjstv8jZQXQDqr2k5MmmQImeohtz6NdhpPo6g01mk3wr03MEQocrkWwsqJ
	 MwaoC/1619wcQ/SO5oU+6f4IYnvkFanx2yym0pJV/xvwF+4Z6QZuE4XeQKBXlyRQ+H
	 vYNsVOKtKn91UKf0em0j2yi/PeZV6hDRQbi/Jm/aAvwNV2D4YctIWNkcEiQ6bwAFn9
	 ggixdwwm+x3IiMHjF83Y1YEq76JDEjcp1eQ1woSvwEyUgXzvYK5FaZU1tA8D4H82y6
	 /FcYIJow+1/MA==
Date: Wed, 24 Sep 2025 17:53:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai
 <wens@csie.org>, Jernej Skrabec <jernej@kernel.org>, Samuel Holland
 <samuel@sholland.org>, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH net-next v7 0/6] net: stmmac: Add support for Allwinner
 A523 GMAC200
Message-ID: <20250924175311.59c6accf@kernel.org>
In-Reply-To: <20250923140247.2622602-1-wens@kernel.org>
References: <20250923140247.2622602-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Sep 2025 22:02:40 +0800 Chen-Yu Tsai wrote:
> This is v7 of my Allwinner A523 GMAC200 support series. This is based on
> next-20250922.

The dts patches don't apply to net-next which prevents our test bots
from processing the series. Could you repost just patches 1 and 2 as
a standalone series for net-next, without the dts changes?
-- 
pw-bot: cr


Return-Path: <netdev+bounces-128558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8788097A53A
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 17:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 480BA28D711
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 15:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80ED815853E;
	Mon, 16 Sep 2024 15:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tN5W6ce9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B73314EC47;
	Mon, 16 Sep 2024 15:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726500210; cv=none; b=L/gJZd5Am4rLSl3N8XzpS6TekiHfViWGKT6KkZhnotSNOg+Z97dMbjuFSejvW9OM+qdsQOCdllla97xJ11AkvJD6LEzTGeoJWRI1OwR4nFNAvu1JtjFOc+TcScKQyf38yJo+jYd6NLrroXNcq2T9NsF2VJcmo/L+VXHNtowke4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726500210; c=relaxed/simple;
	bh=FF+mkLhhU8uH27RYqeySVdh6+IQVVTSZXcZ1I8HSanQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLrj8/TbXDDroCEirMrx/bEgYoRkvXS3H7/kNWVoDhQUajlWF+SHmriEduPQ6p0u6jspr7Uq2rOCQT20oiWDn+l0bKFpTYTwaf2FCfIVzXKy1mRwKE7vcB/YQrSXnIr4LombR6rhOVZeu+EDDjCgk/shqpR2GT7zvXqzOWcm/+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tN5W6ce9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD772C4CEC4;
	Mon, 16 Sep 2024 15:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726500210;
	bh=FF+mkLhhU8uH27RYqeySVdh6+IQVVTSZXcZ1I8HSanQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tN5W6ce94XXmdEQVD13WHFfzJPNTD2CJVS4cq5vSuxLAU2owRauPYKfQ5j2RVNfui
	 LO8dSwTZG4LBSySzF4pxdpqg3soXomuYxFf7kUctuVEGWs7kYEcEV3+n9IBx7kp7AK
	 wKmuJkMsx3EtB6ueC3R5MItUEd1svpOGgRpS4lj3pQ1Y9S0iTGuvCuf9oMhVKtJ1Gl
	 nOy3kxGdoODuX5O9nj1HwA+68GU6+kviJBwhocOYUXeFKXa/X59KEAJBCm52Ndagm1
	 OSr2EthyHoI0zCWijCb14abvGBjL1pIJuy9rZXyCjb9smAUQL9qzgJzUhFhSUv8YuP
	 vGw9QwExaNJug==
Date: Mon, 16 Sep 2024 16:23:25 +0100
From: Simon Horman <horms@kernel.org>
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v1] stmmac: mmc: dwmac4: Add ip payload error statistics
Message-ID: <20240916152325.GB396300@kernel.org>
References: <20240916094812.29804-1-minda.chen@starfivetech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916094812.29804-1-minda.chen@starfivetech.com>

On Mon, Sep 16, 2024 at 05:48:12PM +0800, Minda Chen wrote:
> Add dwmac4 ip payload error statistics, and rename discripter bit macro
> because latest version descriptor IPCE bit claims include ip checksum
> error and l4 segment length error.
> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>

Hi Minda,

Some feedback on process.

net-next is currently closed for the v6.12 merge window.
Please consider reposting this patch once it re-opens,
after v6.12-rc1 is released, likely about two weeks from now.

RFC patches, and fixes for net are, OTOH, welcome any time.

Also, when posting patches for net-next, please explicitly
target them as such.

	Subject: [PATCH net-next] ...

Link: https://docs.kernel.org/process/maintainer-netdev.html

And lastly, I don't think 'mmc: ' belongs in the patch prefix.
This is an Ethernet driver, right? Looking over git history,
it seems that 'net: stmmac: ' is appropriate here.

	Subject: [PATCH net-next] net: stmmac: ...

-- 
pw-bot: defer


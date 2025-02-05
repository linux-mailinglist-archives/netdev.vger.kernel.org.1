Return-Path: <netdev+bounces-163003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44363A28BA8
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 14:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38BE63A894F
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 13:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5293086328;
	Wed,  5 Feb 2025 13:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HqZqVUj1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231937FBA2;
	Wed,  5 Feb 2025 13:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738762118; cv=none; b=HxDobiNlyFOeFj685F7BLg2CCCQ5g+/marakfhuCeM7d/qWYyKEPxsawSfUmxmtnuQJTsm1zGPTVm2nY5gO9zH3VJFqkN8OKwJyvDyM+8bIexC9RICtah3ZVpmcN2U4dnL6gE2k0ShP/NjmG4F/SEEe534Pi62ZysqjAhoGVmPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738762118; c=relaxed/simple;
	bh=EJfYr9VPPROrpKyvvsXKomKL0zPZ75XOGiybaCRJ5J0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QS+INZi5dtsIKtemdPcBO6FQa9a83MdbiCgXgkFrLSApwxph6w4CfEB3VDYkjYpPCJrGAout6nx+5rZX54GYK9qXlm/ivKs+Q9lcqdbamp212E26xgKHmSV8/boLu8qqaaINT4dci3QmhEieDLQLDNc140N1EYxluE5mnoneB8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HqZqVUj1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07CB4C4CED1;
	Wed,  5 Feb 2025 13:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738762118;
	bh=EJfYr9VPPROrpKyvvsXKomKL0zPZ75XOGiybaCRJ5J0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HqZqVUj1urhFmxfS7BZaGcVlHiD+B3a8phvTlc3h6SuZUgQ9q6lCSZCVRhzmm0fIN
	 IG3BXFEDM4SFyqfvIMNZjaScWgkMDWyjY3ao51GKPnNtOtYOUqEPwLSItUyvQB258H
	 Ni8jznOsiG6eSi14La95ih4q1Dh0Ndc2BNfedS+BnJc+4idYaR4g9iVTvAPO0IqJ1u
	 2jLPxfqez+qNon6F81IgxWQRQKMTameMFSHqbV38ma3b4lJB0AjVixKqb9xACw2phL
	 5E9h539vI0Mhwq+BZgmkHpJyxuMAI/LMlrYWIz+XxeuqZ8PW8stQhTHeONAYCJI2Zm
	 rxOSjOG7HVA6Q==
Date: Wed, 5 Feb 2025 13:28:32 +0000
From: Simon Horman <horms@kernel.org>
To: =?utf-8?B?Q3PDs2vDoXMs?= Bence <csokas.bence@prolan.hu>
Cc: Laurent Badel <laurentbadel@eaton.com>,
	Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	imx@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH] net: fec: Refactor MAC reset to function
Message-ID: <20250205132832.GC554665@kernel.org>
References: <20250204093604.253436-2-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250204093604.253436-2-csokas.bence@prolan.hu>

On Tue, Feb 04, 2025 at 10:36:03AM +0100, Csókás, Bence wrote:
> The core is reset both in `fec_restart()` (called on link-up) and
> `fec_stop()` (going to sleep, driver remove etc.). These two functions
> had their separate implementations, which was at first only a register
> write and a `udelay()` (and the accompanying block comment). However,
> since then we got soft-reset (MAC disable) and Wake-on-LAN support, which
> meant that these implementations diverged, often causing bugs.
> 
> For instance, as of now, `fec_stop()` does not check for
> `FEC_QUIRK_NO_HARD_RESET`, meaning the MII/RMII mode is cleared on eg.
> a PM power-down event; and `fec_restart()` missed the refactor renaming
> the "magic" constant `1` to `FEC_ECR_RESET`.
> 
> To harmonize current implementations, and eliminate this source of
> potential future bugs, refactor implementation to a common function.
> 
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Fixes: c730ab423bfa ("net: fec: Fix temporary RMII clock reset on link up")
> Fixes: ff049886671c ("net: fec: Refactor: #define magic constants")
> Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>

Reviewed-by: Simon Horman <horms@kernel.org>



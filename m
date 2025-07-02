Return-Path: <netdev+bounces-203506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 089F8AF62FD
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 22:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D43E17BFEE
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 20:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008562D46B1;
	Wed,  2 Jul 2025 20:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/RNYMYr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB38317B4EC;
	Wed,  2 Jul 2025 20:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751486896; cv=none; b=LMBDfm0g7Xl4bKIT9aKln8Hr7L1gTDE+OEXhpjqxQVeIQgAjTo9B+hkEE1l8K+W9ttpnixwgGCjlWZCVnqcHbzToaj0hU5KM/OMrwEmezjk0gp3+FM9kdVn+Vwj4iPOkyTB7l8U++aQgTi3m0Hh1mkKgPZjK178MdAKPH602Dfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751486896; c=relaxed/simple;
	bh=+oBwcjeXye1ezY+NsOoZuIn8nraxussnxeqwIJCYMJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F1AA4bjU+01+Clgg3JeEW16nA1epJw+ZrCNcXzWPy14qBMlA99/ZRx1F4q0rMWkNfmeE1rFvaNrl1Dl6Bg+fayz2mQKo/oCDqq9WL9iqOvTVlqiDbz5G0hKjnh5nuC25+uKTIT04YruTYNsVW1gGzHUVM5nMbXnWdEuGUoQLX1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/RNYMYr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74E27C4CEE7;
	Wed,  2 Jul 2025 20:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751486896;
	bh=+oBwcjeXye1ezY+NsOoZuIn8nraxussnxeqwIJCYMJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F/RNYMYrSwjwbV5M8+fCYw3SAd7h2cIXRTNhPv0dC2pgHLn0ohZMWKbfpGeWei0XV
	 XnPTvJKHOVRNWktwBm/ScK81vhVxnNspKQi/CF5PUL48McDQyWfTFjRbj87q6py5cS
	 vtMrIG+XoXf1XKE2LJdlLY6BF46s+TD56dabaRcI54/+A9jMyTyBTKqeKEFG/PLKVp
	 vYqg1TObebG28niU/1KQEp7gbXdVFizwUCkT3mTnY5n35Ojb78CFrtEkc429alRGHW
	 poHsOH6lC6PuHRyuX7KR4ZqBQFhUPGY0FbiEFtXcXrtbdFtTxvnhAVaKbJ2kYlAEHi
	 1KNc7ZpQGVK5w==
Date: Wed, 2 Jul 2025 21:08:12 +0100
From: Simon Horman <horms@kernel.org>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: Chris Snook <chris.snook@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: ag71xx: Add missing check after DMA map
Message-ID: <20250702200812.GI41770@horms.kernel.org>
References: <20250702075048.40677-2-fourier.thomas@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702075048.40677-2-fourier.thomas@gmail.com>

On Wed, Jul 02, 2025 at 09:50:46AM +0200, Thomas Fourier wrote:
> The DMA map functions can fail and should be tested for errors.
> 
> Fixes: d51b6ce441d3 ("net: ethernet: add ag71xx driver")
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
> ---
>  drivers/net/ethernet/atheros/ag71xx.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
> index d8e6f23e1432..0e68ab225e0a 100644
> --- a/drivers/net/ethernet/atheros/ag71xx.c
> +++ b/drivers/net/ethernet/atheros/ag71xx.c
> @@ -1198,7 +1198,8 @@ static int ag71xx_buffer_size(struct ag71xx *ag)
>  
>  static bool ag71xx_fill_rx_buf(struct ag71xx *ag, struct ag71xx_buf *buf,
>  			       int offset,
> -			       void *(*alloc)(unsigned int size))
> +			       void *(*alloc)(unsigned int size),
> +			       void (*free)(void *))

FWIIW, I'm of two minds about this free parameter.
On the one hand I like the symmetry with free.
But on the other the two callers both pass
skb_free_frag as this argument.

But I lean towards what you have being a good choice.

Reviewed-by: Simon Horman <horms@kernel.org>


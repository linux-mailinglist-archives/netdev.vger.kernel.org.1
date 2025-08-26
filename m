Return-Path: <netdev+bounces-216982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B35B36F21
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 17:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9B011BC2F6D
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 15:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E677136C06C;
	Tue, 26 Aug 2025 15:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RU/r9Sun"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED6136C085;
	Tue, 26 Aug 2025 15:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756223550; cv=none; b=f82cPyOzuP3vY9pNnLQoaQpEiS4p9xiy9xPMoPQ9Yb+gIaRZnXvVoSeIjQXRwJ/Vlf4rpRB/BEBBXHJOlGcEkzY/+dzwc4EGAmm8ZwSD2mjDfBZKcKvZ2kMD3CBJaJO3NMK5IYpf93bJz0NtXrE4La55qZy8lDHYy0S28A1KSH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756223550; c=relaxed/simple;
	bh=uDBeTmPv8qUYnsaeZ6TQuJA23FxviL4Fghpbh0NN7H0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJCSmg2akczdoB7Zd1uKKRvpNf2KWqVSxAHl4igYXXlc7ui0uEJT6yYIHvH8DKJ/a8Yy01WqHhwfzXUnJBVBdpX/U65y0giZqMUcNiottNbeiHcDAv2jJxLeGuoUUp3gNn7yiMC5354qYP7yI4DK3p1mbsMXz3sBHCzLN8j8o40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RU/r9Sun; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1301DC113CF;
	Tue, 26 Aug 2025 15:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756223550;
	bh=uDBeTmPv8qUYnsaeZ6TQuJA23FxviL4Fghpbh0NN7H0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RU/r9Sund3xTkuhzXlsz26/E/R4O9PNZ55Tn1GMiDSKHLmR99Ol6YPFWTZjI5FJqE
	 bDbkq+eNy2l+nLHRcJ9cTsCi8FZb1YByUp5OHOcqg9wKRx3qDz6sukonGTOpnLM2Zn
	 yFuji07uxovAaXITbxGjY+AlaztCS9b/wpe14rtxd47QScdAcz9hhSGw3uknrLr/AC
	 azurJFt84j+V0sYz9U+33vwZsaulP0X9KAZhAbw6A60jilpq+iRxQ/F7hKBRzQMPhW
	 CKpLQyeyy0AxMSNPXu2fNlogGe20Ik5dbGs/10vo8AoGqFlsociW4k9/JX7P0R9OiW
	 rPyWxzt/w0Qtg==
Date: Tue, 26 Aug 2025 16:52:25 +0100
From: Simon Horman <horms@kernel.org>
To: Kohei Enju <enjuk@amazon.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kohei.enju@gmail.com
Subject: Re: [PATCH v1 iwl-next 2/2] igbvf: remove duplicated counter
 rx_long_byte_count from ethtool statistics
Message-ID: <20250826155225.GC5892@horms.kernel.org>
References: <20250813075206.70114-1-enjuk@amazon.com>
 <20250813075206.70114-3-enjuk@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813075206.70114-3-enjuk@amazon.com>

On Wed, Aug 13, 2025 at 04:50:51PM +0900, Kohei Enju wrote:
> rx_long_byte_count shows the value of the GORC (Good Octets Received
> Count) register. However, the register value is already shown as
> rx_bytes and they always show the same value.
> 
> Remove rx_long_byte_count as the Intel ethernet driver e1000e did in
> commit 0a939912cf9c ("e1000e: cleanup redundant statistics counter").
> 
> Tested on Intel Corporation I350 Gigabit Network Connection.
> 
> Tested-by: Kohei Enju <enjuk@amazon.com>
> Signed-off-by: Kohei Enju <enjuk@amazon.com>

Reviewed-by: Simon Horman <horms@kernel.org>



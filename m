Return-Path: <netdev+bounces-225703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E77E5B973FF
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 20:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFFAC2E607C
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 18:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2343B2DF70E;
	Tue, 23 Sep 2025 18:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNt2qT4A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B052836BD;
	Tue, 23 Sep 2025 18:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758653730; cv=none; b=FlPm4gA9M0R9qpHJuWphunE2BN96Q2SsEeMT1yHhov//3EQUZG1gRAzBJwRO+C5X2NlBljZnYAwF2673UB9+z3SVUvcCQ/I7LTe0G+EruPyx4klMe0lk0ncTcpkkpOao/M/r3pzDWpHLwJ66Uxx/EFJgNvmcqv4fy5VfwyfQs2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758653730; c=relaxed/simple;
	bh=BHKsQeIexba7Xof1BMU4XKauM0mWGjlNxi5TOlT8IiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VswXQOdDM8kTv00UBnYPkNSwTgjEOTw8ctKDZHcmknG+iXs/UDlQYHg6tdadISpDeSRotsM8z//4iAneom+pZhgVm9Ze0E7lUnZ8A5ce6vXIOwtHG3kjc3gSR2ARrHgYFazdqTIIAjzsHr7MpZX7nVuUngdna5MylkqL7e8Vgzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNt2qT4A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D3BC4CEF5;
	Tue, 23 Sep 2025 18:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758653729;
	bh=BHKsQeIexba7Xof1BMU4XKauM0mWGjlNxi5TOlT8IiI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fNt2qT4ASoSn3+NiZDbXtGZIyMzCkhROyTOK7aPLJKZg5pmSSLQ3zYhq4OisLnVWc
	 +NPK8xV1rZsvVJarvIGR7iGDyezz0hBYRVMsFJdbV3N6dTvuFA3CpwaG5iGi9UYwNI
	 xI+NR5fSPKRsepAmX1xU/IlBYwYHHOgjmNvSZWxRZSbAmKRBnaxVhqYDD+4V5Wfotu
	 ixhH0QFA5W+EwO2d1kRn/a4nzGFzAek/XpOanANT+NzoVAn2BATZNAkq8mFlVf6zIZ
	 ncr5Bmgml7RLhxtoxJvLUQi+E5o6FKgjME9gzMy5pcwB8/t3g9+qa0SwacaPOL15xk
	 9n8bVe4wbx3CQ==
Date: Tue, 23 Sep 2025 19:55:25 +0100
From: Simon Horman <horms@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] net: airoha: Avoid -Wflex-array-member-not-at-end
 warning
Message-ID: <20250923185525.GL836419@horms.kernel.org>
References: <aNFYVYLXQDqm4yxb@kspp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNFYVYLXQDqm4yxb@kspp>

On Mon, Sep 22, 2025 at 04:08:21PM +0200, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Move the conflicting declaration to the end of the corresponding
> structure. Notice that `struct airoha_foe_entry` is a flexible
> structure, this is a structure that contains a flexible-array
> member.
> 
> Fix the following warning:
> 
> drivers/net/ethernet/airoha/airoha_eth.h:474:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

FWIIW, I was able to reproduce this locally.
And it goes away with this patch applied.

> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Simon Horman <horms@kernel.org>

...


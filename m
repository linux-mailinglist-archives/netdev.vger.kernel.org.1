Return-Path: <netdev+bounces-30275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9269786B22
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 11:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDBF41C20DEE
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 09:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8C4D313;
	Thu, 24 Aug 2023 09:08:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E29CA73
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 09:08:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2781C433C8;
	Thu, 24 Aug 2023 09:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692868113;
	bh=cGe2w464vT5iQRrd8L3sTAx4e+OvBRkYjXHp0yCt0Gk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=quo8P0wxFXUeiy1k5RVcF7e/z/U50j7obbGyAqBdPiEXyp3nFD15tW4j/JmXUaZJ/
	 9Acfd8wXjpOtx6goFSqsxulSGX8KwxVTbnDrIWDj+b38USbrj6lzX1ZInt2CZFfCpR
	 XhuaeeSWxhX9toVGf9WjtNOy7ejOqi/68HrtGQoAShsGphj1pZ9L5qzr2bcOzi6r/7
	 i6Nmg1Nyp28CxJ0+vEAgdybs2Z5mwIqccff6dWf/zyfWq7OIIVxq09QtmdVHqcekMO
	 pm1e/o5+xFX3TyrbnxbpbMVfuFJh6rQtKh3clcTu2NOFD4KPw7CY0gZE0OGlaRVi/Q
	 M/NNUdOyqjxDA==
Date: Thu, 24 Aug 2023 11:08:19 +0200
From: Simon Horman <horms@kernel.org>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Robert Marko <robimarko@gmail.com>
Subject: Re: [PATCH net-next v2] net: generalize calculation of skb
 extensions length
Message-ID: <20230824090819.GG3523530@kernel.org>
References: <20230823-skb_ext-simplify-v2-1-66e26cd66860@weissschuh.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230823-skb_ext-simplify-v2-1-66e26cd66860@weissschuh.net>

On Wed, Aug 23, 2023 at 11:28:38AM +0200, Thomas Weißschuh wrote:
> Remove the necessity to modify skb_ext_total_length() when new extension
> types are added.
> Also reduces the line count a bit.
> 
> With optimizations enabled the function is folded down to the same
> constant value as before during compilation.
> This has been validated on x86 with GCC 6.5.0 and 13.2.1.
> Also a similar construct has been validated on godbolt.org with GCC 5.1.
> In any case the compiler has to be able to evaluate the construct at
> compile-time for the BUILD_BUG_ON() in skb_extensions_init().
> 
> Even if not evaluated at compile-time this function would only ever
> be executed once at run-time, so the overhead would be very minuscule.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Reviewed-by: Simon Horman <horms@kernel.org>






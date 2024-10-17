Return-Path: <netdev+bounces-136577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9829A2295
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 14:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A066E1C24872
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 12:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54EC1DDC0C;
	Thu, 17 Oct 2024 12:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XA0HHfvz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBA81DD875;
	Thu, 17 Oct 2024 12:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729168804; cv=none; b=LFJu7Z0GpjIbXyehwax+xHZbackNKlT9KOtzR/nBFIdKhPdCy4Lk2hNm+qJtWUs7lajrOFy8D6TymliIuY9XuV5IF34P70w1O1Q6hCZR0q5Ye4S9Rvn1k4Vzecxt3jlHxjiM1VW8ZliYyvgijAXoaygVLOxGLvGf8LPE9WSDH+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729168804; c=relaxed/simple;
	bh=aziSEwHLZzybAK2+WNZ7bm+guVLfrdCKsLzTwki6TEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JNVB4bfyz1ThvjtCALYYEnpmtrJJ3BLrZJFd7VPhJV3sARRyIynfR3tgEa3DyWAZs6NHMz/k547KcoKN1fTjfswfYYaqMbW6sBNqZSD/mtfGd/R5OQ0xwK+MKACmQY/Z8u0IV9IRQpDgcL2jHTVecQLrebHrGrAdLoHF2XfYQ9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XA0HHfvz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4317BC4CEC3;
	Thu, 17 Oct 2024 12:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729168804;
	bh=aziSEwHLZzybAK2+WNZ7bm+guVLfrdCKsLzTwki6TEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XA0HHfvzvM5MAGICvN2jxmvRLVqLj6A0MzXKcW+dP9yzORT5Rns18Ph9qoZrNo3FN
	 FC/TYo8WHhusHd3v4aW78EvU6tMswBEBENvmHoSyRyDFNNp5JK8uaBj/iJUvHA2jkM
	 ptUUm3kHTm7AkJnwG7ODZl9BnYHdGwJFzaj6BtVkntgtctrLHjXxsGYkTDG43wIdG8
	 cFkJ2Nm6GISYKnzH9gPmgoeBJSZKtRMC6RZBGtpVyaMGzQiucbnMwTUYw8ap1+1NHM
	 6r0vB3ScCKtGgvkDmajfCNIOyz23A8BnApMwIAI7wg+xga8n/Z5qGMzPOwinIGHSeY
	 O502TiHiZX/cg==
Date: Thu, 17 Oct 2024 13:39:59 +0100
From: Simon Horman <horms@kernel.org>
To: Furong Xu <0x1207@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com
Subject: Re: [PATCH net-next v1 3/5] net: stmmac: Rework marco definitions
 for gmac4 and xgmac
Message-ID: <20241017123959.GI1697@kernel.org>
References: <cover.1728980110.git.0x1207@gmail.com>
 <94705afa1d2815e82c27d3d1a13b2ad6ada8952f.1728980110.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94705afa1d2815e82c27d3d1a13b2ad6ada8952f.1728980110.git.0x1207@gmail.com>

On Tue, Oct 15, 2024 at 05:09:24PM +0800, Furong Xu wrote:
> Rename and add marco definitions to better reuse them in common code.
> 
> Signed-off-by: Furong Xu <0x1207@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>



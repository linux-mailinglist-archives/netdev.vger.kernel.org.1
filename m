Return-Path: <netdev+bounces-244036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C58ECAE0BB
	for <lists+netdev@lfdr.de>; Mon, 08 Dec 2025 20:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AAD2630202EC
	for <lists+netdev@lfdr.de>; Mon,  8 Dec 2025 19:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B632E0B5B;
	Mon,  8 Dec 2025 19:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APAVR5xv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A77B2DCBE3;
	Mon,  8 Dec 2025 19:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765220815; cv=none; b=CHbqqXsgOAZ9qwXljzDSvMx4oNDM2HQZ+lbhwC6Io2IKmFJbAZVg5B4IrZ5LBk/SRWDhxgBsrQSP3BG6SKNeKUwdv1PUmGm0WQYQs1+JlKHptG2SL6t1u6qEG5e/ojRmss6nrfKuJ0SxGEdcoqRTaxa16fW/uq5GbG9th/NI9Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765220815; c=relaxed/simple;
	bh=/t9O5k74/1fFexqjNx27zehxCb0WYuJRVllBn+g0wbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VEM7wDq9udmXGjbZMVWZEAc/YPlZOrmokVUiCOcUKr4f/su81BZ3mVz0PvoponAwKOaejT9n7+03lGdTPanc1lo6TLOJU46xjylXx6gDpd9IY/+dIYpxx/lU1XkTbR3+s+8I+s36VOauNxnEy/KX5NoVl9b5X3kXQg+rXv4M370=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APAVR5xv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21335C4CEF1;
	Mon,  8 Dec 2025 19:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765220814;
	bh=/t9O5k74/1fFexqjNx27zehxCb0WYuJRVllBn+g0wbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=APAVR5xvDBruB7DN4NbOEwV0c2mfdYw/2C20osSWfp6SnRCUtIgTVWKhUgofSmEA9
	 bDMAAWQKkrtxPDkmGX9stJ/lXFqyvCkcgFdlXn9anKwerovq461nyW9fMheU/cWX16
	 6rciuM2MYhWH/SxB2zGTf/jgGaNTfE+J750TMW6fh1P2+NQCLuxtB7neyhnkwKC4nl
	 8O8EIOQE4R4ii1L5uMPsdUumvRYV3YkzJCCNDaSnB+1LbvdUQKHvW3D2P09lAKlo7J
	 5zPzW4aDRw9L/DZmdXvMLZa0ToFqjc+jMkXLuZVMfHLKOmg8oKcQdrkEAdPdSWB0wI
	 87AQHRIYGtxPQ==
Date: Mon, 8 Dec 2025 19:06:50 +0000
From: Simon Horman <horms@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ptp: chardev: Fix confusing cleanup.h syntax
Message-ID: <aTchyqGuMDO8eJDS@horms.kernel.org>
References: <20251208020819.5168-2-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208020819.5168-2-krzysztof.kozlowski@oss.qualcomm.com>

On Mon, Dec 08, 2025 at 03:08:20AM +0100, Krzysztof Kozlowski wrote:
> Initializing automatic __free variables to NULL without need (e.g.
> branches with different allocations), followed by actual allocation is
> in contrary to explicit coding rules guiding cleanup.h:
> 
> "Given that the "__free(...) = NULL" pattern for variables defined at
> the top of the function poses this potential interdependency problem the
> recommendation is to always define and assign variables in one statement
> and not group variable definitions at the top of the function when
> __free() is used."
> 
> Code does not have a bug, but is less readable and uses discouraged
> coding practice, so fix that by moving declaration to the place of
> assignment.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Reviewed-by: Simon Horman <horms@kernel.org>



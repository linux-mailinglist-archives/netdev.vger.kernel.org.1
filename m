Return-Path: <netdev+bounces-174539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 937C6A5F1A1
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 11:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBC203B3FE2
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 10:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCDF266B42;
	Thu, 13 Mar 2025 10:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZOGM+hd7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54192661AF;
	Thu, 13 Mar 2025 10:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741863316; cv=none; b=u5zItSoTopIVnSYhB/RVYNSqXq0IaYM23JpoN7kWgXwVWuDKz9KBcuO93I9f7nFA00IhqawKipdv/HCPNlaw+O1y7/la2LfAQM5QjLvvW8yDasSpBBgn7nVnUSy7PNgyum4PXtfMBWnR+3X9q36+PdQJTesKDuzgCFzHzP158zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741863316; c=relaxed/simple;
	bh=pPQxLR7mUcDTayuaXMsqxeXTPk/LH1LGtp5G+bcGp7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CI1GUE0VJD6joDSCcKp/o0PSsWz1/rhfTtfkrFc5a4/gjafQegqLcimIAShHTaMBeeWw2JavAo0822QXH+Hp7shHrdP6M3xS4jgeKr+2z3eNlByXAfMVUfFpjDp3nuTGbyu5lIwhnyPY/8YeSsCyATJF2br/Jwf+wgyf0/tsU8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZOGM+hd7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C1C8C4CEDD;
	Thu, 13 Mar 2025 10:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741863314;
	bh=pPQxLR7mUcDTayuaXMsqxeXTPk/LH1LGtp5G+bcGp7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZOGM+hd7QteUZ3Vg3ekGj7c0wB3cCj0wrm+jN78gO23WJq+hFnocJ3wnYKJFTFUo3
	 XJmXknxs045WaPvQDGfyUxvOxpyY4vQ1pUKD4TCt7GHtFx7nxUU7HhCNqp6+9/+DPX
	 WtHvDmXiWx5WJNtMbHfYzHgr8eNWzplHSS4sAgw3oKPypyFXDqzz4vpGiZ34brGgGx
	 Hd14CjV2FBztSrE4Yjk++4ePKwiFZ183U2LmLcsGyRtK6xL7aqmgFNRkJXP5PjZwpM
	 1nhFa1J0SWDhir3hnxMbSeAy+b6f0qGFXI8VCHa7KsbjARLn8meOC9uxarfQFmjCXu
	 m4qXAe6UMQ4uA==
Date: Thu, 13 Mar 2025 11:54:53 +0100
From: Simon Horman <horms@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Helge Deller <deller@gmx.de>, netdev@vger.kernel.org,
	linux-parisc@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: tulip: avoid unused variable warning
Message-ID: <20250313105453.GA125266@kernel.org>
References: <20250313-tulip-w1-v2-1-2ac0d3d909f9@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250313-tulip-w1-v2-1-2ac0d3d909f9@kernel.org>

On Thu, Mar 13, 2025 at 11:47:42AM +0100, Simon Horman wrote:
> There is an effort to achieve W=1 kernel builds without warnings.
> As part of that effort Helge Deller highlighted the following warnings
> in the tulip driver when compiling with W=1 and CONFIG_TULIP_MWI=n:
> 
>   .../tulip_core.c: In function ‘tulip_init_one’:
>   .../tulip_core.c:1309:22: warning: variable ‘force_csr0’ set but not used
> 
> This patch addresses that problem using IS_ENABLED(). This approach has
> the added benefit of reducing conditionally compiled code. And thus
> increasing compile coverage. E.g. for allmodconfig builds which enable
> CONFIG_TULIP_MWI.
> 
> Compile tested only.
> No run-time effect intended.
> 
> --
> 
> Acked-by: Helge Deller <deller@gmx.de>
> Signed-off-by: Simon Horman <horms@kernel.org>
> v2: Use IS_ENABLED rather than __maybe_unused [Simon Horman]
> v1: Initial patch [Helge Deller]

Sorry, the tail of the commit message got a bit mangled.
I'll post a v3 after waiting for other feedback.

-- 
pw-bot: changes-requested


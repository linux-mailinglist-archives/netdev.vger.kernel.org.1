Return-Path: <netdev+bounces-244163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF15CB0EE1
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 20:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24F1230BD5FD
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 19:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2780230594F;
	Tue,  9 Dec 2025 19:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="haadYiIo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F241D27F171;
	Tue,  9 Dec 2025 19:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765308257; cv=none; b=av81nDqoekyqDhgfI81Eho6aC4HHhRijx6YtyH6tqfx0QWbnAmIDMGgUBHTGMqeZqZSrzJQDinpXRlmCsiO3AVZax1I3v3bxg3MXSEjoBxKEkjO5OU8HXTqLIlpXG4ZW8utuAuSPKt2rH+JwGZIib0ll7f69Uze9FHNmQf0GlbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765308257; c=relaxed/simple;
	bh=E05UfQyxpQn6Tfx1hYQtaiY2PLO6y2FnyY5lmQUU0mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hHAOOe0H7py02SE1piGE4m8P1ZaBij01baZmqoQuVlkv5ukm7Cdq2zVqrS5f8emkUcvWUWf/cRfS+iW2y/MdHoIddSrB2d7W6o1r3Ybp+WDUopxaaH5bNG04B837TooSGkPuOSQrQWXGmx1Gxn1hogzOKORwTZ0TZdWZKrGPr6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=haadYiIo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2427DC4CEF5;
	Tue,  9 Dec 2025 19:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765308256;
	bh=E05UfQyxpQn6Tfx1hYQtaiY2PLO6y2FnyY5lmQUU0mw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=haadYiIop9xxgas8tvMFq6Sb4GXFkAVik8x8erECfEZlNQSEunCozojrREpwIC5aK
	 vkOzo5ZMiHCWUrl8SyStaYgsqEkK8whlezSsRU10OiSdEu8ecaLAfZJ/9yOUuT9mfS
	 NPxWDShkyjosusxh6+c3g+CwhZ+V8z4ttyk+rt/SRyv95J2Qvy7NikQMM9RHRLU3lt
	 BMeMogwIUOsslzGNFhOTxO3QpKon6wsp0u/kjdnbvp7aYZ6tPpovIKc4B46g3t2SEL
	 W9FOUTDt9FfE07JgKhz6oGI30/pGbLAbL8uF9Jvg2NA+I1bJZqksGZwCz521Z6uVSE
	 W7WQ5raUxN8Tg==
Date: Tue, 9 Dec 2025 19:24:11 +0000
From: Simon Horman <horms@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Eric Biggers <ebiggers@kernel.org>,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	Francesco Ruggeri <fruggeri@arista.com>,
	Salam Noureddine <noureddine@arista.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net/tcp_sigpool: Enable compile-testing
Message-ID: <aTh3W-SoRxiWN38e@horms.kernel.org>
References: <95d8884780f3682637f0e93049cc484545464ef9.1764860099.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95d8884780f3682637f0e93049cc484545464ef9.1764860099.git.geert+renesas@glider.be>

On Thu, Dec 04, 2025 at 03:57:31PM +0100, Geert Uytterhoeven wrote:
> Since commit 37a183d3b7cdb873 ("tcp: Convert tcp-md5 to use MD5 library
> instead of crypto_ahash"), TCP_SIGPOOL is only selected by TCP_AO.
> However, the latter depends on 64BIT, so tcp_sigpool can no longer be
> built on 32-bit platforms at all.
> 
> Improve compile coverage on 32-bit by allowing the user to enable
> TCP_SIGPOOL when compile-testing.  Add a dependency on CRYPTO, which is
> always fulfilled when selected by TCP_AO.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> One remaining oddity is that TCP_SIGPOOL has always been a tristate
> symbol, while all users that select it have always been boolean symbols.
> I kept that as-is, as it builds fine as a module.

Hi Geert,

I tested some of the COMPILE_TEST/TCP_AO
combinations and this seems to work as expected.

Reviewed-by: Simon Horman <horms@kernel.org>

However,

## Form letter - net-next-closed

The merge window for v6.19 has begun and therefore net-next has closed
for new drivers, features, code refactoring and optimizations. We are
currently accepting bug fixes only.

Please repost when net-next reopens.

Due to a combination of the merge-window, travel commitments of the
maintainers, and the holiday season, net-next will re-open after
2nd January.

RFC patches sent for review only are welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle

-- 
pw-bot: defer


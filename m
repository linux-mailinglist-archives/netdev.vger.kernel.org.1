Return-Path: <netdev+bounces-219849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCF9B43709
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 11:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FE6D7A651E
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 09:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75672EE61D;
	Thu,  4 Sep 2025 09:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlET7kiw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D1E2D3EC5
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 09:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756977921; cv=none; b=dC3+oPoJZrqfuQ9Z6HdHeC6bu18NXV8CLAhXNJyTEvbAo2Y7NITdTrhowb7H+F5p+SWBdo+OeTorH9+kzFiYToj85iVFMFPp1QTISbL9RrKB4AnWcbBO3pZngnHnfnTSC3DGxAwEHq/kbQXRoHtyyVg9LrCOjhrCeatI14dJCIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756977921; c=relaxed/simple;
	bh=P7srXb/5d6IiI5VMDVADcvZuaQjr3g0+R8+xadKyDv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BvZm6COct8k1PCTNYuHfxRfG8QLq2HFYcF0lStqsFkcT99SCalsj95UBK+Ay9UFWjr0L0KpKvEVJ/FcOjcPao6XhpefXoQ+xN8Zt58cirYzaqTWFRRJqt3B7NrYHA7ZJADXomVldfHTKdI7Tfj+LPwp2hC2wQ8BlXwqxy1PYtqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlET7kiw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C4CC4CEF0;
	Thu,  4 Sep 2025 09:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756977920;
	bh=P7srXb/5d6IiI5VMDVADcvZuaQjr3g0+R8+xadKyDv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jlET7kiwuNItoGB+HQtl+ilnKVQjq39G63H5GlsDDKs4GWHlRBXtTWVwB4zsPbn9X
	 AMwglP13Jpeq1f67zFB69X76Nt8OWdQWQwmluK1j/yEFfReQQveHpOoKx9rM1GUxoB
	 l2E3OPhq4fVjYLiugN2xZYcccQJRFKhYY7XqMkhHIC21lSCIET5KbColHE0PaTarNT
	 GdR8WDy/sUo0F85+MZp/sCB7XfNSuW6GDTl5odK2Qr83DiFkNGOlND1EqStHqhVQ+X
	 4YA4q2jx9t1HKarg7bVWZGzL4F4w9VMvdQBQTQkORz09YTpxTN7bKwmd5GkpePkJqd
	 EzuHkR5WSru5A==
Date: Thu, 4 Sep 2025 10:25:16 +0100
From: Simon Horman <horms@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net] selftest: net: Fix weird setsockopt() in
 bind_bhash.c.
Message-ID: <20250904092516.GD372207@horms.kernel.org>
References: <20250903222938.2601522-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903222938.2601522-1-kuniyu@google.com>

On Wed, Sep 03, 2025 at 10:28:51PM +0000, Kuniyuki Iwashima wrote:
> bind_bhash.c passes (SO_REUSEADDR | SO_REUSEPORT) to setsockopt().
> 
> In the asm-generic definition, the value happens to match with the
> bare SO_REUSEPORT, (2 | 15) == 15, but not on some arch.
> 
> arch/alpha/include/uapi/asm/socket.h:18:#define SO_REUSEADDR	0x0004
> arch/alpha/include/uapi/asm/socket.h:24:#define SO_REUSEPORT	0x0200
> arch/mips/include/uapi/asm/socket.h:24:#define SO_REUSEADDR	0x0004	/* Allow reuse of local addresses.  */
> arch/mips/include/uapi/asm/socket.h:33:#define SO_REUSEPORT 0x0200	/* Allow local address and port reuse.  */
> arch/parisc/include/uapi/asm/socket.h:12:#define SO_REUSEADDR	0x0004
> arch/parisc/include/uapi/asm/socket.h:18:#define SO_REUSEPORT	0x0200
> arch/sparc/include/uapi/asm/socket.h:13:#define SO_REUSEADDR	0x0004
> arch/sparc/include/uapi/asm/socket.h:20:#define SO_REUSEPORT	0x0200
> include/uapi/asm-generic/socket.h:12:#define SO_REUSEADDR	2
> include/uapi/asm-generic/socket.h:27:#define SO_REUSEPORT	15
> 
> Let's pass SO_REUSEPORT only.
> 
> Fixes: c35ecb95c448 ("selftests/net: Add test for timing a bind request to a port with a populated bhash entry")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>



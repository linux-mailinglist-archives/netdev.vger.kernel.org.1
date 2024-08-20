Return-Path: <netdev+bounces-119937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 300EE957A66
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 02:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDBC01F236B1
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 00:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BAA632;
	Tue, 20 Aug 2024 00:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZju0QkW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C172DDA0
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 00:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724113354; cv=none; b=OWqdC4yAmud0Y/dmDcAlwv4qPtrW+GjbDMKeGZGa5NW0EhhTna9AFB3u4ltf6P+K5RqdLTHg9FFxQjzHroOIgy3WAbgsxYCKIdzowFDwlggwXCoDUAZjFUACDLuqa+3Qxhfns0ECr5wmnmwSprW7bhacTNg+vBlgqoivBm+a76g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724113354; c=relaxed/simple;
	bh=f3poAltAY/fXATGbRi2kvrHFOXjjTPbPVVHqUPp5sLM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QtYXyTV6brO+zAmZxzWVXikrFvb0T1KD6RzRDU8rj6FI5me5XfK1zgW+Sw8v8o2Erw1seg9HrXg4wxb+WAE1ssXCrmo46CsHVTLeLLqR29tish2uZ32y0riSk2t3xZBsLWAiWllu2aCQ0D8MaygPNq8i0n/ZuXMvL4dx6Uowm1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZju0QkW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB36FC32782;
	Tue, 20 Aug 2024 00:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724113353;
	bh=f3poAltAY/fXATGbRi2kvrHFOXjjTPbPVVHqUPp5sLM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CZju0QkWWzivPx01MEIdZ8Pt1MetuhmLwvCStQK1HuK7KxMQSWNVhNeIoMibVwcbs
	 84n8AfutpVO5AoBA1t5JBhIZ7jkvNDeBuWKp9YgYMFXGpiDz9hSaWiE5hEOZu3dbVt
	 PAz+Y5YsEH2y+O04AHBymM46mgUeVcUW7k/VAwcEoQGMgKiFu3AIAcA96xn0rj88ud
	 4UsjMgqrhGXEKaXSQkf7yNKcND+hU5AW60yNTRksiNRObhGmocqbZXlA0iNXUJg6kS
	 eenV7rR0Qf2sQVULi1YIqB5DPgCJATwiK0O0fUO9zKJ6tWd9EQ27wH58vds73Ow0yO
	 JM/6LnoRC62Bg==
Date: Mon, 19 Aug 2024 17:22:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
 <steffen.klassert@secunet.com>, netdev@vger.kernel.org
Subject: Re: [Question] Does CONFIG_XFRM_OFFLOAD depends any other configs?
Message-ID: <20240819172232.34bf6e9d@kernel.org>
In-Reply-To: <ZsPXnKv6t4JjvFD9@Laptop-X1>
References: <ZsPXnKv6t4JjvFD9@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Aug 2024 07:39:08 +0800 Hangbin Liu wrote:
> Yesterday I tried to build the kernel with CONFIG_XFRM_OFFLOAD=y via `vng`[1],
> but the result .config actually doesn't contain CONFIG_XFRM_OFFLOAD=y. I saw
> XFRM_OFFLOAD in net/xfrm/Kconfig doesn't has any dependences. Do you know if
> I missed something?

It's a hidden config option, not directly controlled by the user.
You should enable INET_ESP_OFFLOAD and INET6_ESP_OFFLOAD instead
(which "select" it)


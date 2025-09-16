Return-Path: <netdev+bounces-223321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEA7B58B5B
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 03:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ABAF176B0F
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 01:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71082220F38;
	Tue, 16 Sep 2025 01:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GTigC4z1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CADA1AAE28;
	Tue, 16 Sep 2025 01:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757986951; cv=none; b=p2kSbTzkwWDLwC2Hgx9SKIOJ4MzXdX9BinsYOhFinQa2pjobdNYWDdDrH6XFQSAWzk1hrnHu3z2K/F1ppX9fR2RenabnBSY5TtP4rVMVS9DI/BCGEKjlYHMkAU/r+op/n3UWEOrC4hZ3CvqbrwyXK2cbLuBodgTbzRAuVE39jgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757986951; c=relaxed/simple;
	bh=BKmUN1POtBgOVp+wGbEb2h4H2tw4W+500lLeRZM7TLw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cJC6olozafLNQQ2qOBk6JxWflHrAHC65NhHQz8PgnNMogU3483Sdc58+izYV1FqjbmBS8EW47U1HAevKRbmcGPYgtO1T/jpBYfETLxB2AydHQSXfq5aPQCA4oRKvmIJZ2HG/0lPH4UwqFnhcAqNNlt+ZqTXUFc7iUKDyy3vsmyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GTigC4z1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF20C4CEF1;
	Tue, 16 Sep 2025 01:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757986949;
	bh=BKmUN1POtBgOVp+wGbEb2h4H2tw4W+500lLeRZM7TLw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GTigC4z1SbwhaJQDsO3v8Pl2blSrIoZ854dX0fm96Df6ymOD9nyEdr9BD1lJ/xjKq
	 mLWSEPzd9XDJRWr5G5jaf1MHTNFxzili6PT7OA5lcdoIfFvnFz0d9G3WDa1R301wq6
	 GrzO5vYBWB5S1WcUUKhrVQwp22pdxdd1W4wV4kiEHsKpswanEqbQDChK6K6nTM29OT
	 3DpSpkMXRLxTsKtf8ayNXNKSjg2SNTSGaWOj9Tp0G0MFRPE/iANVyztrfkj/XG9X5v
	 m7IbPHnd799qSAOX8+1IFaVxhWdq8SkqrB/hhTliRtCYT0XyzdVC3eqSUffQ2rn5kt
	 FduZ3hlyA98qw==
Date: Mon, 15 Sep 2025 18:42:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4bm5lc2Vu?=
 <ast@fiberby.net>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, Simon Horman
 <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>, Sabrina
 Dubroca <sd@queasysnail.net>, wireguard@lists.zx2c4.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 05/11] tools: ynl-gen: avoid repetitive
 variables definitions
Message-ID: <20250915184228.49fe90ec@kernel.org>
In-Reply-To: <20250915144301.725949-6-ast@fiberby.net>
References: <20250915144301.725949-1-ast@fiberby.net>
	<20250915144301.725949-6-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 15 Sep 2025 14:42:50 +0000 Asbj=C3=B8rn Sloth T=C3=B8nnesen wrote:
> In the generated attribute parsing code, avoid repetitively
> defining the same variables over and over again, local to
> the conditional block for each attribute.
>=20
> This patch consolidates the definitions of local variables
> for attribute parsing, so that they are defined at the
> function level, and re-used across attributes, thus making
> the generated code read more natural.
>=20
> If attributes defines identical local_vars, then they will
> be deduplicated, attributes are assumed to only use their
> local variables transiently.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>


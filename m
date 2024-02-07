Return-Path: <netdev+bounces-70029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C89F784D698
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 00:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01DA41C217AA
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 23:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177BA2560C;
	Wed,  7 Feb 2024 23:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FX1MbzFH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8FE1EB2B;
	Wed,  7 Feb 2024 23:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707348809; cv=none; b=qU/vRwCerQ9pBETeMvY0HsYGVtYWnIMC4rZb0bWn9j+3c2g86B4/NQ3qke/d+2K7HwFoQMIKsro3BdAVv2+XwLjg5ogMzM16BIf+WFiDj/rAe+gkAfGUrUnM0VUmjitB/taD/E3npnsq7Y4lj0CC8eD2rMCuMt4vZRlm8nX0MbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707348809; c=relaxed/simple;
	bh=v+KkGQ/m2w8jCp8yIBBt86Fjn3X9n3Uwu1iwEuTE+eY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qnOW3k0GgY6sw0qkBzeakpeQW2aPCYnJP1mRHWeQlHwV7EJoS1kOt5Cpuy4uVZ/6dVl8AV7FDkOGRi/LNhb9/jRWrmywhgXO81I/O3hL7AGYyBnp7Ed5oiaXACg9TToWRI6vMGk94TUeYxV4jG1JniXjmASNas/KS+mq2ZMy+ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FX1MbzFH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E1EC433F1;
	Wed,  7 Feb 2024 23:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707348808;
	bh=v+KkGQ/m2w8jCp8yIBBt86Fjn3X9n3Uwu1iwEuTE+eY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FX1MbzFHOAH+Lr1Y05FgNzW1cU5fT0ZY8f0iWlVnSn+4IU4OsVUCb/porJ3mLhnVk
	 sFQ519bMozbb1LsTbqDIy8oLwcysrKReZgJUKwH19BveVYYrFUFii/421uz0SXQU0O
	 +k5DcDCbVO2FuBzKVmE1HQaXH6wXpThI2hk2Ei0xhXTVD1YmzpZZrMBUrs9mtWFmLa
	 ehfu2AvX4GmcamLeJrwt/x7NYdsXAdUNplgsWofcWW7KA196vFGkEnnbAkS0di967W
	 fGQfQzyDKEND9NBIyjk+haI9c3KBdP+UGfnpFeleUj5KEVJu82cFMz0UHSnSgn7GVs
	 p8OfsgJ9wPn3w==
Date: Wed, 7 Feb 2024 15:33:27 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Matthieu Baerts <matttbe@kernel.org>, Marco Elver <elver@google.com>,
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov
 <dvyukov@google.com>, kasan-dev@googlegroups.com, Netdev
 <netdev@vger.kernel.org>, linux-hardening@vger.kernel.org, Kees Cook
 <keescook@chromium.org>, the arch/x86 maintainers <x86@kernel.org>
Subject: Re: KFENCE: included in x86 defconfig?
Message-ID: <20240207153327.22b5c848@kernel.org>
In-Reply-To: <20240207190444.GFZcPUTAnZb_aSlSjV@fat_crate.local>
References: <e2871686-ea25-4cdb-b29d-ddeb33338a21@kernel.org>
	<CANpmjNP==CANQi4_qFV_VVFDMsj1wHROxt3RKzwJBqo8_McCTg@mail.gmail.com>
	<20240207181619.GDZcPI87_Bq0Z3ozUn@fat_crate.local>
	<d301faa8-548e-4e8f-b8a6-c32d6a56f45b@kernel.org>
	<20240207190444.GFZcPUTAnZb_aSlSjV@fat_crate.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Feb 2024 20:04:44 +0100 Borislav Petkov wrote:
> On Wed, Feb 07, 2024 at 07:35:53PM +0100, Matthieu Baerts wrote:
> > Sorry, I'm sure I understand your suggestion: do you mean not including
> > KFENCE in hardening.config either, but in another one?
> > 
> > For the networking tests, we are already merging .config files, e.g. the
> > debug.config one. We are not pushing to have KFENCE in x86 defconfig, it
> > can be elsewhere, and we don't mind merging other .config files if they
> > are maintained.  
> 
> Well, depends on where should KFENCE be enabled? Do you want people to
> run their tests with it too, or only the networking tests? If so, then
> hardening.config probably makes sense. 
> 
> Judging by what Documentation/dev-tools/kfence.rst says:
> 
> "KFENCE is designed to be enabled in production kernels, and has near zero
> performance overhead."
> 
> this reads like it should be enabled *everywhere* - not only in some
> hardening config.

Right, a lot of distros enable it and so do hyperscalers (Fedora, Meta
and Google at least, AFAIK). Linus is pretty clear on the policy that
"feature" type Kconfig options should default to disabled. But for
something like KFENCE we were wondering what the cut-over point is
for making it enabled by default.


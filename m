Return-Path: <netdev+bounces-94281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B60588BEFC8
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 00:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71C902869EF
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 22:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F9C15B0FC;
	Tue,  7 May 2024 22:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+pacHjw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B47478C72;
	Tue,  7 May 2024 22:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715120928; cv=none; b=GwGx4iwc5iyhAo+TxVPd+daL5CGWKNMM27FDGKUoZVk/jG+Jrqg0GVgWvhJcl/PcgtOYQfGENoiIzIz92Htki0ez+QLkqJgSKhsLMtZ5g44TQM7GA6ntZnQMsyZOQOtoz2QJ8TiFx8Z3wev75OLSn8K2Z/LYwKwU5Kd/8EmB6e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715120928; c=relaxed/simple;
	bh=AhHacpsAkDO0cfrGSXsn8MOL5MP+OQrgVockeJaRTgs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XFtFy32LYMPZg5RYPZCUZO/8owynsW2xl257fEqbEtbsNGgG928QFnc4qPv6mzGUJJV8ciL6jr39dDQ+jZif5ZLeIpmAOozdrcKgc0tRqTnLB7vk1UcUCaZIlutVyCaZfzkLJ9j8/k6thOSh0FLLXgTGm1WPJptO0QINVeaP3eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+pacHjw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C2D1C2BBFC;
	Tue,  7 May 2024 22:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715120927;
	bh=AhHacpsAkDO0cfrGSXsn8MOL5MP+OQrgVockeJaRTgs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m+pacHjwAPOaQ9alqDSAo2+wRT9GczYdwx+GXOzL4eOmnh+oTytRTfXZAp9N33nUa
	 wpWRZmBGal+kfdqcviAu4agzhmnh2+N2q3CD2f1cds/Rt3JCpdtuHk3XxKZ6iTpP8/
	 aMUsNkI8x0z/LS79ctNvXLuFYCZ9lV4jI9hwvnUcfEu7jDix7WOxonrDvcf5VLVChS
	 D+KJM/yJAphk7F9cHaLGVFHEoFTUbqtHaCN1cfdzYUJcZJY1E8vmSNB5UBgo5Y6BQG
	 7LFQUjHc3xpIC8ecWb7ONTu861VhB57AAyZgth0qiVhp8cjjg/0rfkD/q5wInCAnE5
	 6Sqw4xnSYDwjw==
Date: Tue, 7 May 2024 15:28:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jeroen de Borst
 <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>,
 Shailend Chand <shailend@google.com>, Nathan Chancellor
 <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Bill
 Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Dan
 Carpenter <dan.carpenter@linaro.org>, Kees Cook <keescook@chromium.org>,
 netdev@vger.kernel.org, llvm@lists.linux.dev,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] gve: Minor cleanups
Message-ID: <20240507152846.30d7c11b@kernel.org>
In-Reply-To: <20240503-gve-comma-v1-0-b50f965694ef@kernel.org>
References: <20240503-gve-comma-v1-0-b50f965694ef@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 03 May 2024 21:31:25 +0100 Simon Horman wrote:
> This short patchset provides two minor cleanups for the gve driver.
> 
> These were found by tooling as mentioned in each patch,
> and otherwise by inspection.
> 
> No change in run time behaviour is intended.
> Each patch is compile tested only.

Looks like it conflicts now, please rebase
-- 
pw-bot: cr


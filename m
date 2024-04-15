Return-Path: <netdev+bounces-87798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BCA8A4AC7
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 10:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D70D61C20E67
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 08:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05AA3A1DA;
	Mon, 15 Apr 2024 08:48:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3705C383B0;
	Mon, 15 Apr 2024 08:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713170905; cv=none; b=XYBAvfCcKaKyyFdL2nHuFCe5EXOpf/pvAXOI7xlAZih6NERA5k1Zm9uynJKb5megSxz7qyFzEhRIvhSsO5bH/8o3wppnlVSv/CHvw1/NFsvD0myBkFVwOdFw/DPsU6A03nCAUKF7/nNMCI1B4Y5HLXaMlWnxJFaDZQPldkxsoz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713170905; c=relaxed/simple;
	bh=aUTpqR90HGSXb+d29zMbh59e0EIbmHWWgEa1C/CA4YM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sy924A73NE7peReHYLyb5gP0mg57glPtXClLR2FAP3HPDFOWHloUBhxSyVfCtK6Zdo9zDFnyfQirsQ39R7eWclSj0XnGhyzQXER45JkkEXSwT0c+opsuGj/wJo4PTC8r8Ao7JPRQ2N5pc/gWmFojY4zsOzEUzYlby+HB4zEMRAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Date: Mon, 15 Apr 2024 10:48:09 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH net-next 00/12] selftests: netfilter: move to lib.sh infra
Message-ID: <ZhzpwyKEDPd4y9T2@calendula>
References: <20240414225729.18451-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240414225729.18451-1-fw@strlen.de>

On Mon, Apr 15, 2024 at 12:57:12AM +0200, Florian Westphal wrote:
> This is the second batch of the netfilter selftest move.
> 
> scripts are moved to lib.sh infra. This allows to use busywait helper
> and ditch various 'sleep 2' all over the place.
> 
> Last patch updates the makefile with the missing bits to make
> 'kselftest-install' target work as intended again and adds more required
> config settings.
> 
> Missing/work in progress:
> 1. nft_concat_range.sh: it runs for a very long time and also has
> a few remaining issues.
> 2. some scripts still generate lots of warnings when fed to shellcheck.
> 
> Both issues work-in-progress, no point in waiting because its not
> essential and series should not grow too large.

Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>

Thanks Florian


Return-Path: <netdev+bounces-216951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67441B3663E
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 15:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3B881B261F0
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 13:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6446935082A;
	Tue, 26 Aug 2025 13:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FD6jicna"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED5F34F49D
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 13:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216077; cv=none; b=G8579KV3Ar/UY2QExbTzoC6IV94nsGcerxpcJ0apqI01SJQDg1+Bqt8jZaM72sB5xlZEHXbzC/d033ESwMPjHhnsBs76voVIYj7DEP9LmLfX2P5shEaUsoXHyrDO3a2YjryOD20azrZZPD7ATbmFtTsMNf1SDXy82FRwL/kSj6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216077; c=relaxed/simple;
	bh=trn6cRrTkrMqvUgkGauLbpWUQtdXMaUIFAX1dQNoIVM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bbFNLcWjxn4tZB6qbhoonVjNQH5SoTfbR0ULvUAi8Feb8x/5c01sdoH25mT/YPQ3ufWiCW59L705s6UI5IXUuddFGohz2n4Sswo7LBzS0/barZtykVqOVnl61vj6pZgQvrNP7k7AYDX/R9FwnjLnnvCiRKrtWtss6id4NvsPk7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FD6jicna; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34A1CC113CF;
	Tue, 26 Aug 2025 13:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756216076;
	bh=trn6cRrTkrMqvUgkGauLbpWUQtdXMaUIFAX1dQNoIVM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FD6jicnaBG0qnZLjx4bMPfvKk0ItYz0KhPHeBMfSMvNnOiALuYo75dYoK2ylk5ZCQ
	 QsKs/bhRFvaHk7pf7CowMs1uUEn511/LadIqkBbLV147RAgo6wvEDMdyFrWjmdPt/a
	 fsBdMqRHFyRGhAhJr28xXOHxUHl3lASPA6x+E8yeKa6KAvCN48IW7MRESedlVFvKZd
	 PwdBHMTBlBrXOeKmFCCEqEJC5Efc4XuSpUd825aRt5iJbRXdH4dhE22r+wprTUy1gn
	 NWMqs48CaINLSm7Gy9Ma07Wno29uHTKoHtM+Z5AY5NZo0KhiVpj6QjTsFfQNybqkeh
	 bQSFnjPiGNEfg==
Date: Tue, 26 Aug 2025 06:47:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 dhowells@redhat.com, gustavoars@kernel.org, aleksander.lobakin@intel.com,
 tstruk@gigaio.com
Subject: Re: [PATCH net-next] stddef: don't include compiler_types.h in the
 uAPI header
Message-ID: <20250826064755.6462354d@kernel.org>
In-Reply-To: <202508251953.F5194A2@keescook>
References: <20250818181848.799566-1-kuba@kernel.org>
	<202508182056.0D808624D8@keescook>
	<20250820101752.63be03da@kernel.org>
	<202508251953.F5194A2@keescook>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Aug 2025 19:54:44 -0700 Kees Cook wrote:
> > Not sure this is the most fortunate approach, personally I'd rather wrap
> > our empty user-space-facing defines under ifndef __KERNEL__. I think
> > it'd be better from "include what you need" perspective. Perhaps stddef
> > pulling in compiler annotations is expected, dunno...  
> 
> I'm trying to leave the door open for userspace to start using these, if
> they defined them too.

Makes sense.


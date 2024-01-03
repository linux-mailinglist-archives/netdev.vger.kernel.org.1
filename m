Return-Path: <netdev+bounces-61192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3DF822CD7
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 13:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58F9F1C232EF
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 12:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30E618EC0;
	Wed,  3 Jan 2024 12:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kc5T1kXk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1B918EBD
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 12:19:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5CB6C433C8;
	Wed,  3 Jan 2024 12:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704284387;
	bh=YxUmT5IqDQWAZV/7luNRQjE+6ko1bQl0j63ohnhnN9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kc5T1kXkP5e8qEm32sOzgUNhsG0jLRQfyqI+5f3bbi3fJ15d4nhBqBMoH8EiuTDbQ
	 tfU194rIQmhGBmeALE5ARpJikc35KbRvrR3Z4yqkEhoYUhWtekNc0+pL2x5MEjWW3k
	 czcnDJGNYEoEVyqFzECV9uGAH+tWGniuHQx/lhkGNe2296M/j75POzhXvOuqOU/p30
	 R6Ii2O6vDNzf6fLgKHxPX42WGJ4wrAgJf8y0vUo4HyoScG4saSFJ8x8JARQfBjJdL3
	 yw2Hi7T0OiniS8FFSyCgdF4ePVUgMoPqsY+U+3y3BDBcnhmAU1RCwzKmPkyUbSBhZP
	 QB0T9xkjKsj+w==
Date: Wed, 3 Jan 2024 14:19:42 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Subject: Re: [RFC iproute2 0/8] rdma: print related patches
Message-ID: <20240103121942.GD10748@unreal>
References: <20240103003558.20615-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103003558.20615-1-stephen@networkplumber.org>

On Tue, Jan 02, 2024 at 04:34:25PM -0800, Stephen Hemminger wrote:
> This set of patches makes rdma comman behave more like the
> other commands in iproute2 around printing flags.
> There are some other things found while looking at that code.
> 
> Stephen Hemminger (8):
>   rdma: shorten print_ lines
>   rdma: use standard flag for json
>   rdma: make pretty behave like other commands
>   rdma: make supress_errors a bit
>   rdma: add oneline flag
>   rdma: do not mix newline and json object
>   rdma: remove duplicate forward declaration
>   rdma: remove unused rd argument
> 

In addition to Chengchang comments.

LGTM,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>


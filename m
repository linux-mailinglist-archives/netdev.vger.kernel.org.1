Return-Path: <netdev+bounces-120606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFBF959F04
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 15:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5794281308
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 13:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3B51A4B6D;
	Wed, 21 Aug 2024 13:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OgMD9QDs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE56B16631C
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 13:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724248141; cv=none; b=jiVtAC7oQ6VbDvfCWWRWmbxQk01G6VMrjzyjlDgPn1VDaafa88sAoz+1TM+aenP5jEYmFqDeXPG6XR2XxOkkBvxgT6XV5O3Zge4cTzNkiJ1slkok6b/MazbknCPSlDV65vvWov5VCJ3YP1qOIxDhHM7OaKHBgL5rQQ7FQfrqy64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724248141; c=relaxed/simple;
	bh=5X52JyHmH1aJDRkMBij/awkUBBpzyt0qa3ewz1SCoBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G02WaOYmaFHaUt48Kxhjmw4b3WkhzopH+yeM05KHIdsy8iP3MSCWAQYHQNtSP8M6CVxb2+gFD9CzAkVqw8ivB/2uQ9kHvcli5y6wZoTl2rTH4d0/0OyGx8XgdUDFx5reddYylug+GtJfffoDbOEgovQvv5C4MPdwBdhJYF8wtJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OgMD9QDs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CE59C32781;
	Wed, 21 Aug 2024 13:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724248141;
	bh=5X52JyHmH1aJDRkMBij/awkUBBpzyt0qa3ewz1SCoBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OgMD9QDsBlPR0zERAfQZt1h6CFPvhMV1GAzBhcIVtkQ1/AHxKCHNh1Sl9RQiNLjDm
	 Ctxke1+q29J7FVPuSGfXVvK4UgNl10jnDsnVzgXGcykbW0Q9k/kilam6dzzWTUpgHY
	 fDmDkumFNNG7JyjJRrZGVt4C4HhzNJNGxzTI8eugAU07ZDSCbHMjWjE9txOFuhDL5I
	 pmrS2CIHhgZT8ALkemeP2Yyy5tBJ5Ezpstj0rNZ+Nllzhg/hbQLntzsb/zBCbpCboh
	 Oh6T6TLJa0GJOM32VYVIqpO9sLLZNljfDrSd+IvubCkleMkcbqA9L2PBaJpb9WxKdb
	 bNm2JjjwDIiYQ==
Date: Wed, 21 Aug 2024 14:48:58 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net] netpoll: do not export
 netpoll_poll_[disable|enable]()
Message-ID: <20240821134858.GD6387@kernel.org>
References: <20240820162053.3870927-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820162053.3870927-1-edumazet@google.com>

On Tue, Aug 20, 2024 at 04:20:53PM +0000, Eric Dumazet wrote:
> netpoll_poll_disable() and netpoll_poll_enable() are only used
> from core networking code, there is no need to export them.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>



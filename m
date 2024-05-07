Return-Path: <netdev+bounces-94260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 597148BEDE0
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 22:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EDA31C24D2F
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 20:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F3714B97A;
	Tue,  7 May 2024 20:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvO7jtjL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7291A14B978
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 20:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715112475; cv=none; b=YV3frYT8PG0diDs4lBFzehT5mVnnpfU8Ircx2YsYubFHY8mITsCY6nokoWB10eBIvQKDA4tyJHh2e+zWOzHH7mOzLTJNVBNnC/ydkP1nokRj46HioyPs5HT+kPN28LbaIJ+RlZSHBj8UqWx/KZ0GJRxUyGf6c4fSiABzqBoU0OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715112475; c=relaxed/simple;
	bh=6Yzy5NRIRHt2a5pVloCIt1I5sm0E/sITlW3djp/rxTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XnAhRqLvNNfahIsoQxcfRpwbVCUotfnbz68CyQUcy2OhAgmFV0ygBzXgOPjS5CDgD/Hq2nVdT4bj067eiVYZPqpcNuYhQS9YDvAM/jBwF94xoQYKfkbIGwFKWw8v8t3ExvOJUvzssKQ6XDXEGwcA2FVCqdmT5UjGleMQNZ75yWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvO7jtjL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8237CC2BBFC;
	Tue,  7 May 2024 20:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715112475;
	bh=6Yzy5NRIRHt2a5pVloCIt1I5sm0E/sITlW3djp/rxTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GvO7jtjLgQkJWfMp3bDHeBlakqLVTfQVVCWmZDOBsbwBcxOwpoBQojwJqjQ2qtPYr
	 bVhE8gn4PG+ow59S0laLiHnHRAmIkBupVv7Lc/hCok0jxxUDbLqvrpMmw5jnCHmRNI
	 jeABBdB3Kt1X4xlmUKkmjeqbkcqkAxsqHdmlTo9pyfJkEIRIKPKr/5aqZbGFLDOAgE
	 DL5Ed9t5fUMbtjxHKYSIlGGhqJhyzdIybkOTHV157pYJ4FJVgDfORdRCamK/WOiTkD
	 3tDnGwEG2aAIgeCqP2IHuFptYuqBFnz0NGe11cSb3Ko0js9G+bu0GxZhyK+To6wclN
	 3G7xU1ObqXnaw==
Date: Tue, 7 May 2024 21:07:51 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] net: annotate writes on dev->mtu from
 ndo_change_mtu()
Message-ID: <20240507200751.GK15955@kernel.org>
References: <20240506102812.3025432-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506102812.3025432-1-edumazet@google.com>

On Mon, May 06, 2024 at 10:28:12AM +0000, Eric Dumazet wrote:
> Simon reported that ndo_change_mtu() methods were never
> updated to use WRITE_ONCE(dev->mtu, new_mtu) as hinted
> in commit 501a90c94510 ("inet: protect against too small
> mtu values.")
> 
> We read dev->mtu without holding RTNL in many places,
> with READ_ONCE() annotations.
> 
> It is time to take care of ndo_change_mtu() methods
> to use corresponding WRITE_ONCE()
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reported-by: Simon Horman <horms@kernel.org>
> Closes: https://lore.kernel.org/netdev/20240505144608.GB67882@kernel.org/

Reviewed-by: Simon Horman <horms@kernel.org>



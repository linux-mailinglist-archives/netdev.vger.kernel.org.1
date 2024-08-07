Return-Path: <netdev+bounces-116514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B5E94A9FB
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 16:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0FCC1C2011E
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 14:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6506539FFE;
	Wed,  7 Aug 2024 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDqdpJln"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4090A2209B
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 14:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723040499; cv=none; b=hGobPs7jeiXDfEgMNx0pk72OAXY4EPasgjrIqpXbx7Le19HvsWlcn4RreWxfRkuSl8jpPCxRVwqYh67PBvcz7ez0J/oPGTF6CcnwItD+H+sJrSYpNgespfRNZv6pEUbSrIXkRSVeioFxi0Nh/F9LHTzTSGuG7vej7KQkuBXeffQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723040499; c=relaxed/simple;
	bh=SMXTuNh5WWDSxTmrVDzLYH/DbOrli3NXWZk8Ft7GtSs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hH0pPeuVm7FVW7RclzEfblf2pXOg0/uwyQC2w+nu0huh8cteLI2jeQx2ACeGXMlUO94/pDgUWb4QlMTTi4qOU8WrmeOz5qnMayJXCWGvamg162ocKzLndVG2jLGcVY0amhcI7LelNBFE2H8w2w+c+sMb+adS/2zRF2iTi/7HyWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDqdpJln; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A756C32781;
	Wed,  7 Aug 2024 14:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723040498;
	bh=SMXTuNh5WWDSxTmrVDzLYH/DbOrli3NXWZk8Ft7GtSs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hDqdpJlnVxoHqCTWbh1CGJyV+ZNU8q0k4muKQ5/x0a+oX93M2usz9trNkqzPY7bSr
	 YQuo294qacPWPVxiH+wDPoPJQeVJtn+IY5VzHJMUxkpjhGRQtBEHfH8Zrn6QMXdWyW
	 zz669Z8GMMQWBH6K77VAkQ96VFSu6DSwJoHoDaKgN+5bkk4RTNNVFH5mkJc4X+B5L0
	 zXc7xKPpdLzRD5VWaqGQVhoP0rfJZv35rKf+P9i4vEIr6Lu1RDyRd76/fAyIPDbXa2
	 7UGQkqV4Sju2k6JWMc0eVf34ux6a9sjuDwoNaJtxMMjkRrJr6iCZa9vc3vfDycllLO
	 fCj+iIObpPWjw==
Date: Wed, 7 Aug 2024 07:21:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Dragos
 Tatulea <dtatulea@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>
Subject: Re: [PATCH net] ethtool: Fix context creation with no parameters
Message-ID: <20240807072137.34d300a8@kernel.org>
In-Reply-To: <20240807132541.3460386-1-gal@nvidia.com>
References: <20240807132541.3460386-1-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

At a glance I think you popped it into the wrong place.

On Wed, 7 Aug 2024 16:25:41 +0300 Gal Pressman wrote:
> -	if ((rxfh.indir_size &&
> +	if (!create && ((rxfh.indir_size &&
>  	     rxfh.indir_size != ETH_RXFH_INDIR_NO_CHANGE &&
>  	     rxfh.indir_size != dev_indir_size) ||

This condition just checks if indir_size matches the device
expectations, is reset or is zero. Even if we're creating the
context, at present, the indir table size is fixed for the device.

>  	    (rxfh.key_size && (rxfh.key_size != dev_key_size)) ||

similarly this checks the key size

>  	    (rxfh.indir_size == ETH_RXFH_INDIR_NO_CHANGE &&
>  	     rxfh.key_size == 0 && rxfh.hfunc == ETH_RSS_HASH_NO_CHANGE &&
> -	     rxfh.input_xfrm == RXH_XFRM_NO_CHANGE))
> +	     rxfh.input_xfrm == RXH_XFRM_NO_CHANGE)))

only this validates the "is this a nop", so you gotta add the &&
!create here

That's why I (perhaps not very clearly) suggested that we should split
this if into two. Cause the first two conditions check "sizes" while
the last chunk checks for "nop". And readability suffers.

Feel free to send the new version tomorrow without a full 24h wait.


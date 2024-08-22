Return-Path: <netdev+bounces-120962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 229E595B4A7
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 14:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 556C61C23283
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 12:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077021C9DEB;
	Thu, 22 Aug 2024 12:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epAb79U7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CC41C9DD7;
	Thu, 22 Aug 2024 12:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724328442; cv=none; b=Iso4orYcWtzkume/B0dNx1u6rESkoQnfIGcVaF1xlQ8b0vtcqqZZDCYH/qGoUNZWTg5IshvxQFYJWKaGAB2nA88zwS0R3hdf7ypyb0xnN0SGK7xKvoZyu3jIuZ0130YYz+Z9BxivDvXRp+BuKivBf4mpZDgse+crYeQ0X11fg3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724328442; c=relaxed/simple;
	bh=bNVHEZeZuuF+WF6Lp5y10YTUHR5TUwzNmAJ5/n7BC4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oY9mkS5XCEDH+XVomXu6o5rFfineKzDcJ0ybvqZgg79FJTjxTZmw3nKQS0cGdkTjuF461v0zYcmWUtJEFuh+T+VM+GXyCOBGa+tIFgHPsEIbqPlCeqeVzJ9STME460OIQ+ygtWBeX7Z97oAalGDzojJrjglgZSH/qSMGoyxChUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epAb79U7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85E9EC32782;
	Thu, 22 Aug 2024 12:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724328442;
	bh=bNVHEZeZuuF+WF6Lp5y10YTUHR5TUwzNmAJ5/n7BC4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=epAb79U7IGNYyulK0kNBnMToGFSY+HW+Qd6IXIJvt9zP2MaoMJcxThZ/i936jt3hP
	 KmioCTlvxPlSM5BGoEMRRseTADvnGAcshLmV17CGWVWVna6NFCUU7g4kF+Mw5DNu4v
	 9uw9lOfJBhSaE1ySftjt7lAeHKKtmqVlrys8rxdAZpwsozV6rXaKmjYePUnX7hWFo+
	 pWDhIFE/ldJooyshUGMzFN4r6IYPQHAVSvSq6NCvT/YyGJ36OGLreI0GAq3T3CJY4z
	 zjPupfp9D2zfxgpXw1ZE+P+6iG5uCdkuNbF07nAJNb3WbnKzXhZ5CFAbGL4l9EOv3L
	 e0qSTrEIcj7Gw==
Date: Thu, 22 Aug 2024 13:07:18 +0100
From: Simon Horman <horms@kernel.org>
To: Yuesong Li <liyuesong@vivo.com>
Cc: mark.einon@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v1] driver:net:et131x:Remove NULL check of list_entry()
Message-ID: <20240822120718.GN2164@kernel.org>
References: <20240822030535.1214176-1-liyuesong@vivo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822030535.1214176-1-liyuesong@vivo.com>

On Thu, Aug 22, 2024 at 11:05:35AM +0800, Yuesong Li wrote:
> list_entry() will never return a NULL pointer, thus remove the
> check.
> 
> Signed-off-by: Yuesong Li <liyuesong@vivo.com>

Hi Yuesong Li,

Thanks for your patch.

Some minor points about process.

1. As a Networking patch, that is not a bug fix, it should
   be explicitly targeted at net-next.

   Subject: [PATCH net-next] ...

2. Looking at git history, it looks like 'et131x' would be an appropriate
   prefix for this patch.

   Subject: [PATCH net-next] et131x: ...

Please consider reading
https://docs.kernel.org/process/maintainer-netdev.html

And, please post a v2, addressing the above, and including Mark's tag,
after waiting 24h from the initial patch posting (as described in the link
above). Please do so as a new email thread.

FWIIW, the code change itself looks good to me.

...

-- 
pw-bot: changes-requested


Return-Path: <netdev+bounces-130766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDD998B705
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 10:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A35152827F0
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 08:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F1B199FD2;
	Tue,  1 Oct 2024 08:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+jdEjH5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8F347F53;
	Tue,  1 Oct 2024 08:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727771643; cv=none; b=W8oNQRmATYWxehICgUucWm4HxexojjBvcSWVpDzXMLJLgX5b0YLza45+RqU3Lz7LW1mlZ6LxvhM5AfptgONmUa1GZqkkc4VPnv15LMJWM+fqyIMjXr3bPMtlTRJG07gtgTkL42VRumHsBdbDUDevOg3fGulQJGd2dWturHNykzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727771643; c=relaxed/simple;
	bh=Stk9sSBGF4+cD5LLmr23clRiUDON6NSgnjoS6xre+kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YfkA3VoMIQvghdkDgwuYiYyd7dZo/7bi/OJaO8iAKVvr9Xi9trgqfApyHnZJAMx/9F2MMhrXwfOBJQOrNIr61gXyVxRHhrWsfwJsJ4srvUy9VxT3hjROAUGdzKZQXfa3oAO3Qrak3DL+vZGHY4kay+ekd5qUs3+JS6agF6Oa4SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+jdEjH5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C03CFC4CEC6;
	Tue,  1 Oct 2024 08:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727771642;
	bh=Stk9sSBGF4+cD5LLmr23clRiUDON6NSgnjoS6xre+kc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U+jdEjH57y22S+hYqXa2goCWoVz8jllTYCqMy+estP7WWi6gf6teqh2tO3s7NFyUo
	 3UH77o747oDM2rL7uIjb+bTW+sRQzFauAARB7sdJ3BfZyoz/rjVk2M7uxnDKSjM4Ob
	 qWtAv2pXZob1+wzrDNYAMfNdgXwjdnFSRY89t1GcqzZfa5i+7yGATpP7XqiZTidK3o
	 0z5SxBGRPTvsTgwe2UbWVgq9FAIfhmmoKPGt9Zkx6XOcCqZypFjLQjgPet8b2cCvtT
	 7t7wp3UkNVws3rF9scBic+8HNT8DgF9aY+wWpWPL5aD5stYt2T6GNFUd7BumwRrSMB
	 DAwKIogxf/pNQ==
Date: Tue, 1 Oct 2024 09:33:58 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, Matthew Wood <thepacketgeek@gmail.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	davej@codemonkey.org.uk, max@kutsevol.com
Subject: Re: [PATCH net-next v4 10/10] net: netconsole: fix wrong warning
Message-ID: <20241001083358.GJ1310185@kernel.org>
References: <20240930131214.3771313-1-leitao@debian.org>
 <20240930131214.3771313-11-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930131214.3771313-11-leitao@debian.org>

On Mon, Sep 30, 2024 at 06:12:09AM -0700, Breno Leitao wrote:
> A warning is triggered when there is insufficient space in the buffer
> for userdata. However, this is not an issue since userdata will be sent
> in the next iteration.
> 
> Current warning message:
> 
>     ------------[ cut here ]------------
>      WARNING: CPU: 13 PID: 3013042 at drivers/net/netconsole.c:1122 write_ext_msg+0x3b6/0x3d0
>       ? write_ext_msg+0x3b6/0x3d0
>       console_flush_all+0x1e9/0x330
> 
> The code incorrectly issues a warning when this_chunk is zero, which is
> a valid scenario. The warning should only be triggered when this_chunk
> is negative.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Fixes: 1ec9daf95093 ("net: netconsole: append userdata to fragmented netconsole messages")

Reviewed-by: Simon Horman <horms@kernel.org>


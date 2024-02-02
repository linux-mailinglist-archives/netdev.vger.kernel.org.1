Return-Path: <netdev+bounces-68467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 401EC846F92
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 12:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 350E6B26A2A
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 11:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E5A13EFE3;
	Fri,  2 Feb 2024 11:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ih4UzVvz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE4C13E233;
	Fri,  2 Feb 2024 11:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706874904; cv=none; b=uH2eZMbjXEYOaZMjN/bWWJhDDG8g18fCO19fZ5dvawGzWvefUfC8XnvHECUd9xN6r2UCQjkET8jk3rw5d9HyS3rt/rW5+j4LhCEvHBvUQGO8FPxbUu07Oh2WsOR3/Dg0mJ0mPTdCv2E8vS7+/gLx8kRc42ol4GIQ5JmsCTKfd4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706874904; c=relaxed/simple;
	bh=0rsf8rEwPN7l+sZRb7Vel03fado/1fE6W/Zbap4tgdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RpQMTL+7RDi4qzKcujzBC8GZBAD5oht9eHhotDZciFHv75MwHdAhtSFowXqoquCht9feRYRpVQIXzpJW84+h23ZjZDAwCuNRP7mP8cIOMN7xLwS1i/4plvrIYB20vJ6JJYBSDR43UszXWil6Jy2uTFSAzFLd++g1cNvkm3GgGeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ih4UzVvz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE7CC433C7;
	Fri,  2 Feb 2024 11:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706874903;
	bh=0rsf8rEwPN7l+sZRb7Vel03fado/1fE6W/Zbap4tgdg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ih4UzVvzD71Vh4DujrIrHPHocAEX28dkzpBbE55Jn/vEmPTHm+GmCNcn6/sC0NNO6
	 fZ+kgq1R7Lf1X5JuZ0fnGdjtG9tzlZ19d40HJOweaaOI1MKFr3pwMFD586uu5RWJJR
	 DI06gNkL8FfJcVU+Jluj5v2p1sJJiRpaSy/VRJtozmClMJfO5ohd7zGcJv6+FsCSxO
	 b0uwsR5GxPIPLmEaJRpWQlCeTpXfr7DEU2LGNnISwTxmuFK2Ils7do3zgGvq7OtFnZ
	 wXiVzvmUF+LWwiw/AqiAi57xAYE5lpmMaUbvwd4UZlmZ5fVW3od6AmDi60LpyenYU1
	 bLJU7O0BitVNA==
Date: Fri, 2 Feb 2024 12:54:50 +0100
From: Simon Horman <horms@kernel.org>
To: Matthew Wood <thepacketgeek@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	leitao@debian.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/8] net: netconsole: move netconsole_target
 config_item to config_group
Message-ID: <20240202115450.GN530335@kernel.org>
References: <20240126231348.281600-1-thepacketgeek@gmail.com>
 <20240126231348.281600-3-thepacketgeek@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126231348.281600-3-thepacketgeek@gmail.com>

On Fri, Jan 26, 2024 at 03:13:37PM -0800, Matthew Wood wrote:
> In order to support a nested userdata config_group in later patches,
> use a config_group for netconsole_target instead of a
> config_item. It's a no-op functionality-wise, since
> config_group maintains all features of a config_item via the cg_item
> member.
> 
> Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
> ---
>  drivers/net/netconsole.c | 61 ++++++++++++++++++++++------------------
>  1 file changed, 33 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c

...

> @@ -665,8 +669,9 @@ static struct config_item *make_netconsole_target(struct config_group *group,
>  	if (!strncmp(name, NETCONSOLE_PARAM_TARGET_PREFIX,
>  		     strlen(NETCONSOLE_PARAM_TARGET_PREFIX))) {
>  		nt = find_cmdline_target(name);
> -		if (nt)
> -			return &nt->item;
> +		if (nt) {
> +			return &nt->group;
> +		}

nit: no need for {} here.

>  	}
>  
>  	nt = alloc_and_init();

...


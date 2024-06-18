Return-Path: <netdev+bounces-104287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEEAC90C0D9
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 03:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 803641F225E4
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 01:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D44C7483;
	Tue, 18 Jun 2024 01:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/JF3Rex"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2EC4C6D
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 01:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718672407; cv=none; b=BQCgqRZCASqG1lQjyApXbLVSYGNxhRHFGX5Tcc3PbF3iXeGMXkl39TYsvW1SmqJpLXNC1KJ2Ot+Fhjh1lkhrpE3Oy0ARttT2oVhJ6LxJseWHqGg9nKe+Ak50rHPqIOowzaUTqLgrb6xSucYGHnZF1ArQLN5cRVS1bJGUDo2hrkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718672407; c=relaxed/simple;
	bh=kHHKAiRtOGPVtpcYgzcOCO7NjOMSkM2ZpXCzEGuHxfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VBzVhVGBlJNooGk0cqBTvLteRvouMEOGP8cHq7hIbQXKxFRqja8/5uv5vXtvMkifecj0JK8NWm7qNvBLuJKQ4jQKn2YXtRYPjmhUhGISNQ+uL+arK4bdJt6Qy3Yt/RLGWcefbJNXb5J24w2gxmOKgGLbojXpzFrBocZYyARxkw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/JF3Rex; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F52FC2BD10;
	Tue, 18 Jun 2024 01:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718672407;
	bh=kHHKAiRtOGPVtpcYgzcOCO7NjOMSkM2ZpXCzEGuHxfQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B/JF3RexKcev8AO6ODoWOaASLYaPk/taBZK1xqgXl7DjsozBOiBHSv8scB6PB32x1
	 beftkC7wQZTJeN2LEnWmPzQkxrIIIU/x+aBDsEsU9BSNyzQYuDtRSAkVx1bHhSCJym
	 RRBaT3+9+xYSFrkEtiPEDYTiCSR0kNfoPIEiwCCtM5TYmcAVnuVhlnAR5CpbZpJiKd
	 H40Zbo5KVJwi6TDr6sjAaCYZEHB1JBM1iqBSombsAKvxjux+1kKYJOF4maQDDOLKtv
	 oCdpc0+DUYC93GT7yVjJotGylPfcRY+O/y4s7aOgmawS7fG4U+CrFIGmmZXwDHfjNC
	 k8gdYh6srY4Cg==
Date: Mon, 17 Jun 2024 18:00:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kamal Heib <kheib@redhat.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Paolo
 Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: sun3lance: Remove redundant assignment
Message-ID: <20240617180006.767ebff9@kernel.org>
In-Reply-To: <20240614145231.13322-1-kheib@redhat.com>
References: <20240614145231.13322-1-kheib@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Jun 2024 10:52:31 -0400 Kamal Heib wrote:
> There is no point in initializing an ndo to NULL, therefore the
> assignment is redundant and can be removed.
> 
> Signed-off-by: Kamal Heib <kheib@redhat.com>
> ---
>  drivers/net/ethernet/amd/sun3lance.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/amd/sun3lance.c b/drivers/net/ethernet/amd/sun3lance.c
> index 246f34c43765..fe12051d8471 100644
> --- a/drivers/net/ethernet/amd/sun3lance.c
> +++ b/drivers/net/ethernet/amd/sun3lance.c
> @@ -296,7 +296,6 @@ static const struct net_device_ops lance_netdev_ops = {
>  	.ndo_stop		= lance_close,
>  	.ndo_start_xmit		= lance_start_xmit,
>  	.ndo_set_rx_mode	= set_multicast_list,
> -	.ndo_set_mac_address	= NULL,
>  	.ndo_validate_addr	= eth_validate_addr,
>  };
>  

We seem to have a lot of these:

$ git grep -E '^[[:space:]]\.[a-z_]*[[:space:]]*= NULL,' -- drivers/net/
| wc -l
287

and we try to discourage folks from sending cleanup patches to
very old device drivers. So, unfortunately, I'd prefer to leave 
this code as is.


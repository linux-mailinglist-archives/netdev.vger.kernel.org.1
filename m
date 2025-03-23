Return-Path: <netdev+bounces-176974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FB0A6D066
	for <lists+netdev@lfdr.de>; Sun, 23 Mar 2025 18:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C04207A4592
	for <lists+netdev@lfdr.de>; Sun, 23 Mar 2025 17:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193121632C7;
	Sun, 23 Mar 2025 17:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qsBVY8ic"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92411624CA
	for <netdev@vger.kernel.org>; Sun, 23 Mar 2025 17:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742752090; cv=none; b=HkPSc4t+h+ybkooUL4nVcRkccyHRFG6YUE2iPtie5anz0dFoB3G138v2JlZ4uQ8AEwXQL2z0wcMzoZHB2PPvvJX7MJVeYPw7KZ7N9whYR9GR2ozB880DkN1pCgAJkeQLAtCCrCzV09QHx/960S+CvrXZvC3qiiUOtG3fvF/oLc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742752090; c=relaxed/simple;
	bh=ymed5GKuJjmcpUcaDBphbVWZrAOuQgGJ8nHrqTgaMZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qzLCYfiJdoulPRm0r2ipWfQrfI7/I03PsqXG6IdQXxYy0R7/0Gux0V6MlQfzUr+iWPhGon2mbVBZlv9PJditkPqj65xeQyrhh0q9JwQ+hfmyfJ42EN0YGfmeOGkRt+J4KR9tI7c762RF8iiXCwtkoM4p5/kWDAywtwrhaOihTo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qsBVY8ic; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3BA5C4CEE4;
	Sun, 23 Mar 2025 17:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742752089;
	bh=ymed5GKuJjmcpUcaDBphbVWZrAOuQgGJ8nHrqTgaMZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qsBVY8icZ0MsnJ+cgHhddVt2680bZTJKOZn+Uirnin/gDoTI4awnyfv/kVtZHmTK6
	 LNiLlaFjAeBTxZu6qi5bjoQ9sWj/R7v7lJtD3uduwRwxKQn+D84uD87BeNsqWa9GjN
	 6nydaSpSEjY51slZIFosPa/u5pZp2g2CQZEt5tJsJkp1jQfOWT7GMyezyKukR61XNH
	 i/lgTzLETPueP6Ol2H6/ZGn2dvra+5eLWikKFXbhZ1cLlWdcFBr2/3dPdC/rpH8c7u
	 O16XKn3tLgDWYQJiNsg0zxX4OjeF+kv2yw3CrD61DBkA/zvEHEkwQGv6Usecc72U0D
	 vT5Bpw/QutR0w==
Date: Sun, 23 Mar 2025 17:48:04 +0000
From: Simon Horman <horms@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, saeedm@nvidia.com,
	leon@kernel.org, tariqt@nvidia.com, andrew+netdev@lunn.ch,
	donald.hunter@gmail.com, parav@nvidia.com
Subject: Re: [PATCH net-next v2 4/4] net/mlx5: Expose function UID in devlink
 info
Message-ID: <20250323174804.GC892515@horms.kernel.org>
References: <20250320085947.103419-1-jiri@resnulli.us>
 <20250320085947.103419-5-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320085947.103419-5-jiri@resnulli.us>

On Thu, Mar 20, 2025 at 09:59:47AM +0100, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Devlink info allows to expose function UID.
> Get the value from PCI VPD and expose it.
> 
> $ devlink dev info
> pci/0000:08:00.0:
>   driver mlx5_core
>   serial_number e4397f872caeed218000846daa7d2f49
>   board.serial_number MT2314XZ00YA
>   function.uid MT2314XZ00YAMLNXS0D0F0
>   versions:
>       fixed:
>         fw.psid MT_0000000894
>       running:
>         fw.version 28.41.1000
>         fw 28.41.1000
>       stored:
>         fw.version 28.41.1000
>         fw 28.41.1000
> auxiliary/mlx5_core.eth.0:
>   driver mlx5_core.eth
> pci/0000:08:00.1:
>   driver mlx5_core
>   serial_number e4397f872caeed218000846daa7d2f49
>   board.serial_number MT2314XZ00YA
>   function.uid MT2314XZ00YAMLNXS0D0F1
>   versions:
>       fixed:
>         fw.psid MT_0000000894
>       running:
>         fw.version 28.41.1000
>         fw 28.41.1000
>       stored:
>         fw.version 28.41.1000
>         fw 28.41.1000
> auxiliary/mlx5_core.eth.1:
>   driver mlx5_core.eth
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>



Return-Path: <netdev+bounces-176969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0F4A6D035
	for <lists+netdev@lfdr.de>; Sun, 23 Mar 2025 18:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E5907A59B6
	for <lists+netdev@lfdr.de>; Sun, 23 Mar 2025 17:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FAB13B29B;
	Sun, 23 Mar 2025 17:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBxyDBHz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24381DFF7
	for <netdev@vger.kernel.org>; Sun, 23 Mar 2025 17:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742750357; cv=none; b=bOVy3qDHwqg9Z0nXFbXo7uXKeY/gK3NFJoR2jlZOUHJNzm+wTJ/YCfBjwSn/c7Ic1DdTckme/iGgnNASNgoQy7SWKgdLDBbgfltBovth6blwVRFhsACg1JGw2fOQIDQc+iZKFziCF9P169FExB7NGR2c9mIJS1+/i3b/Z03f9dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742750357; c=relaxed/simple;
	bh=YPjLmbDy1QjVoIUvLlNXxBgZhmEtNOf4K3uYs326dKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KXKDvvs9CllUT5WV8OUykeyacRRpGsCfy3UWIArDFDRwrHeBHg2olYx5bAYs9wltKvXu9mqV7tRjp3ChsWsuW/KllZLs3Dj7O61ZD4uU/yv1fF4X0hTX7HY6FMescq023tQ7zr6hykGwn9O1fwA18T67wLzISq5HBigMmKl64d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBxyDBHz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42020C4CEE2;
	Sun, 23 Mar 2025 17:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742750356;
	bh=YPjLmbDy1QjVoIUvLlNXxBgZhmEtNOf4K3uYs326dKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nBxyDBHzWEi0Yp6ksTqFUFTifd1la1iHaABBnQqSVKiR5X+iK2YkM3rzHUjBDGmwo
	 Eh6ncaXmw3e0I8UUu/rw/Qp2/SDVJYnTyWAno0+BDb57JBhOIXzi7ZRp+vuNKyzjbB
	 kaZY4uM2Po1YnYP2r3DqU9ZizKLwm4e4z0fh5brsWGRRVw2DRYC3x2mSwGR+DEFNgX
	 ctw20qHtv6DuloqAH2y4rcCMDd451WkNWknEjuQB7hfabnpvo8dIPhyqAXbITuAyiQ
	 /+t+QS23Y5xVVrSRjuqcg7uXzECeFEgLdSF/v+5vlBN5XmgHjE+naPDr2p8kpBtHV9
	 EiCxNuvmAsJ2Q==
Date: Sun, 23 Mar 2025 17:19:10 +0000
From: Simon Horman <horms@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, saeedm@nvidia.com,
	leon@kernel.org, tariqt@nvidia.com, andrew+netdev@lunn.ch,
	donald.hunter@gmail.com, parav@nvidia.com
Subject: Re: [PATCH net-next 4/4] net/mlx5: Expose function UID in devlink
 info
Message-ID: <20250323171910.GX892515@horms.kernel.org>
References: <20250318153627.95030-1-jiri@resnulli.us>
 <20250318153627.95030-5-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318153627.95030-5-jiri@resnulli.us>

On Tue, Mar 18, 2025 at 04:36:27PM +0100, Jiri Pirko wrote:
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



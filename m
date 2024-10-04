Return-Path: <netdev+bounces-132002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BE79901E2
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 13:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99140B22BC2
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 11:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2102B156F57;
	Fri,  4 Oct 2024 11:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5Yv7xDe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E0713DDD3;
	Fri,  4 Oct 2024 11:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728040444; cv=none; b=uHDmb/zy2T7K705i9ggkJpdJqcJYgBf1efTspgfG/RyU6kNZu1/tH0RQjQsGXMWJzRyPvT2iqVvAYf5AHmB5WI30E/YUEbiHXCJsimol8MR05sRxGtH7oq0o2PxA5WZijS7yVDOAGk1bI3FxKdfKRtrf4bcCajYFlzRtxq6sArE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728040444; c=relaxed/simple;
	bh=DGc/W0UrKEUGOcaleW8QUdWu58sIZuwBFC6pQA6pPg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MIeB9xUpbcH+qatJzdbvxKLShD7q++Urr7shzcqw1lQy8XJr7TptYi94inGHVSNv847/tCLTRfvTnDlBFFFQWHyEC4GYIWoNH6x3ZqOzP4LtZvSz/9Yd+jkXfB8dpq/XwQzNhmsv9T/a2Iuqc36UJOo58OVChSj/w5NBlk9EA8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5Yv7xDe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA784C4CEC7;
	Fri,  4 Oct 2024 11:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728040443;
	bh=DGc/W0UrKEUGOcaleW8QUdWu58sIZuwBFC6pQA6pPg4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f5Yv7xDeibAmEYdBfg4FTCnKH4Bawxoi0s+lf6yFF2REePik0spkZQ1jRskqqdxOd
	 XGY5cFlxaABdr1GETPvOGrqtbIgpWjU212S2NO7aGnfj1lG5AE11XX4bFzK10yJUxl
	 P+eyfPXVyyKbwXsBYFj7lMd92/Mfrxd9qxzGU0Xcv11BwonfIjYJWvCdkcqnCn69WK
	 T3LnoG+vg0p4vjaaQLtmivVluteoGCSGMQJHiLbcVXwYphSPFvFYxthBfJcs+CdGWF
	 T6DyQKz8AaCqS3aOV2KG4GCU/e5R8Pth74Jiz06sjyzVJQ8A3QS27SlguCKxsRL+2H
	 0QqbzhvU+iUGA==
Date: Fri, 4 Oct 2024 12:13:59 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: macb: Adding support for Jumbo Frames up
 to 10240 Bytes in SAMA5D2
Message-ID: <20241004111359.GE1310185@kernel.org>
References: <20241003171941.8814-1-olek2@wp.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003171941.8814-1-olek2@wp.pl>

On Thu, Oct 03, 2024 at 07:19:41PM +0200, Aleksander Jan Bajkowski wrote:
> As per the SAMA5D2 device specification it supports Jumbo frames.
> But the suggested flag and length of bytes it supports was not updated
> in this driver config_structure.
> The maximum jumbo frames the device supports:
> 10240 bytes as per the device spec.
> 
> While changing the MTU value greater than 1500, it threw error:
> sudo ifconfig eth1 mtu 9000
> SIOCSIFMTU: Invalid argument
> 
> Add this support to driver so that it works as expected and designed.
> 
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>

Thanks Aleksander,

This appears to be consistent with:

233a15875396 ("net: macb: Adding Support for Jumbo Frames up to 10240 Bytes in SAMA5D3")

Reviewed-by: Simon Horman <horms@kernel.org>


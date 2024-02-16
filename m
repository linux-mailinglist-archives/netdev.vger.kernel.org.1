Return-Path: <netdev+bounces-72270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EDD857596
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 06:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9B12B21B61
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 05:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF7C12E47;
	Fri, 16 Feb 2024 05:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qrqCfSha"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B068BF0
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 05:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708061036; cv=none; b=MpCW/g3aRHBFtS8sf35GGLuuf6tHUVZctjn+TbrTkjhCW/6nqRikbGfKa+Kv1qS5RNyXHdMLo0oN773bYNww/70tP/g0OZa2ryGS5gCIHEwpd8xqxEwWZYAqdNJ1L2sV1acytYqGA4zYkA1rU6n4DR7PwkFrs8fPCzyxeLdxNdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708061036; c=relaxed/simple;
	bh=YWyBg9VSOqGtGGJoKgrGQkSe/3IzwKYXSYodTO7z+4M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fACA+Vujc5qLPIJe4rWSDKODEwq32tHk7u/Q0J4NG0oQkgY/4gSUU9iOS4mRqVhLNTX2GbHAUWzUfUhLLgvsCXVGI8yFqGSPy45aDpwWmwIKp0vR78g/6rljarf7brsDSv7ZAoRIT3s2/84G7qwbfbFOCLezkbHpeXcoa+X5kLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qrqCfSha; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A4B6C433C7;
	Fri, 16 Feb 2024 05:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708061035;
	bh=YWyBg9VSOqGtGGJoKgrGQkSe/3IzwKYXSYodTO7z+4M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qrqCfSha+83E0Tuw2LZoS/4XPRwzFoS/z3adt+qpqMO4l/IpjjdvYAYaMPo/CSKgn
	 fO4NPyDIBwelpsd9IAH7hF5hRKy1RlfAv9kkMWVmXUWIN40aTvH2ERrW+PYn5KGqd2
	 wqaJSzMSM6Rz0Fp/P/GW/VW8kpFDjP8HGyjx/uFUjOXTe3yaJ2/2Vi9AwqNbJGQS0l
	 gLnWwu/Zw2jmH56uKJG6h4e/bYhuGK7+sQGFav386DH2sJfO8mcoSk7EVW1soUl8KL
	 rKtx/21btlOfehSsybTKHttdng+1U5aUaAPaoRQQ0nidjza3jDLMtJPOm4PwLMBZqZ
	 pgjgC6d9L9oHA==
Date: Thu, 15 Feb 2024 21:23:53 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Saeed Mahameed
 <saeedm@nvidia.com>, netdev@vger.kernel.org, Tariq Toukan
 <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
 <leonro@nvidia.com>
Subject: Re: [net-next V3 15/15] Documentation: networking: Add description
 for multi-pf netdev
Message-ID: <20240215212353.3d6d17c4@kernel.org>
In-Reply-To: <20240215030814.451812-16-saeed@kernel.org>
References: <20240215030814.451812-1-saeed@kernel.org>
	<20240215030814.451812-16-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Feb 2024 19:08:14 -0800 Saeed Mahameed wrote:
> +The advanced Multi-PF NIC technology enables several CPUs within a multi-socket server to

There are multiple devlink instances, right?
In that case we should call out that there may be more than one.

> +Currently the sysfs is kept untouched, letting the netdev sysfs point to its primary PF.
> +Enhancing sysfs to reflect the actual topology is to be discussed and contributed separately.

I don't anticipate it to be particularly hard, let's not merge
half-baked code and force users to grow workarounds that are hard 
to remove.

Also could you add examples of how the queue and napis look when listed
via the netdev genl on these devices?


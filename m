Return-Path: <netdev+bounces-66667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D8684034C
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 11:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE48FB22D18
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 10:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6769C5B5BA;
	Mon, 29 Jan 2024 10:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1teB6vR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B795B5B6
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 10:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706525768; cv=none; b=hcymwFGn0QuiDpIXJOHWDoeLxfMGwgmmX/8clfbT2cJaNB04wEmtIcr9MseQFU0BlFC2+trGlwFXgsO76Nmj2GGLxtd7NorK0oREdKOGbt+Z3HtXBw9Jyr3Q2aVF8Nkpyr8z2/r6c6ilOpSXMmtFzykBLZRcHlj/wtr6tmQgpI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706525768; c=relaxed/simple;
	bh=SfFWuAygcHizF+f996dYYVed86TOjiGLRxPpMN/Tj2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dnk4bOHS6OG4qRE0JDsRVjaYcV2O1o+nOUTqEITwkJBCWeOH04+ULlTDaNErI60oAQG/OFisWH4ajt7U83kVtTFV6ptckxKO4unEuQMs0+KMS/pJwMm3iY+HhAWW+ZvDvVdoAu9lvMusV5z9ISPdnnHIhQH2Ahao564dR3VsmHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1teB6vR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B9EC41674;
	Mon, 29 Jan 2024 10:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706525768;
	bh=SfFWuAygcHizF+f996dYYVed86TOjiGLRxPpMN/Tj2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y1teB6vR9MO6jzB6ki44PdyRCAAfewj3kV7qnqPQ6foSsGRSVj3Hg1yWnYdpHb0/v
	 og5NtpMEyaAOlYzrmFWH2Kj+3Q60ysCA7ddr0fU+RpA7KQ298no/ZWc55DIFiP8RF8
	 qdG+tgxZ2Vk+c5dXCgmJVX1qBoWYtv3otY+sRZz2nwHSRjrEwSjVyoP/H5HYm7j1H1
	 uFZPSEoj3uTo1E5tGFNrDFVenOZy56hTiBywHtCsAkRVK4BDYT2F7WvQiwHOS18+CW
	 0oZ7EeHptgLnIqE7wGj+LaZZnZxiR5bh92Z/JCigk65jv4QTNCYWMo1XoIsp6hyFmZ
	 XA69veebyl71w==
Date: Mon, 29 Jan 2024 10:56:04 +0000
From: Simon Horman <horms@kernel.org>
To: William Tu <witu@nvidia.com>
Cc: bodong@nvidia.com, jiri@nvidia.com, kuba@kernel.org,
	netdev@vger.kernel.org, saeedm@nvidia.com
Subject: Re: [RFC PATCH v3 net-next] Documentation: devlink: Add devlink-sd
Message-ID: <20240129105604.GI401354@kernel.org>
References: <20240125045624.68689-1-witu@nvidia.com>
 <20240125223617.7298-1-witu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125223617.7298-1-witu@nvidia.com>

On Thu, Jan 25, 2024 at 02:36:17PM -0800, William Tu wrote:
> Add devlink-sd, shared descriptor, documentation. The devlink-sd
> mechanism is targeted for configuration of the shared rx descriptors
> that server as a descriptor pool for ethernet reprsentors (reps)
> to better utilize memory. Following operations are provided:
>  * add/delete a shared descriptor pool
>  * Configure the pool's properties
>  * Bind/unbind a representor's rx channel to a descriptor pool
> 
> Propose new devlink objects because existing solutions below do
> not fit our use cases:
> 1) devlink params: Need to add many new params to support
>    the shared descriptor pool. It doesn't seem to be a good idea.
> 2) devlink-sb (shared buffer): very similar to the API proposed in
>    this patch, but devlink-sb is used in ASIC hardware switch buffer
>    and switch's port. Here the use case is switchdev mode with
>    reprensentor ports and its rx queues.
> 
> Signed-off-by: William Tu <witu@nvidia.com>
> Change-Id: I1de0d9544ff8371955c6976b2d301b1630023100
> ---
> v3: read again myself and explain NAPI context and descriptor pool
> v2: work on Jiri's feedback
> - use more consistent device name, p0, pf0vf0, etc
> - several grammar and spelling errors
> - several changes to devlink sd api
>   - remove hex, remove sd show, make output 1:1 mapping, use
>   count instead of size, use "add" instead of "create"
>   - remove the use of "we"
> - remove the "default" and introduce "shared-descs" in switchdev mode
> - make description more consistent with definitions in ethtool,
> such as ring, channel, queue.
> ---
>  .../networking/devlink/devlink-sd.rst         | 296 ++++++++++++++++++
>  1 file changed, 296 insertions(+)
>  create mode 100644 Documentation/networking/devlink/devlink-sd.rst

Hi William,

a minor nit from my side:
I think that devlink-sd should be added to the toc in index.rst.

...


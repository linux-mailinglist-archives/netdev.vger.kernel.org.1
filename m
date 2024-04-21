Return-Path: <netdev+bounces-89867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE538ABFA9
	for <lists+netdev@lfdr.de>; Sun, 21 Apr 2024 16:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4424CB20FE6
	for <lists+netdev@lfdr.de>; Sun, 21 Apr 2024 14:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7EB10A3C;
	Sun, 21 Apr 2024 14:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRYqQRJm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B4C199B9
	for <netdev@vger.kernel.org>; Sun, 21 Apr 2024 14:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713711259; cv=none; b=PXBbH2vGwE6LtrWcv2ztNKOoky2s9dZewO5CuA4u5TjwnUbkAtno9Wyy62iCzXoT1HyzDa2x6zgLXRZRLfLYHGpZteYFSDZ3auolUWfQ7IpIdPrhYOcdNc3B2/mFqEjprK7XZmcQ/Zqrr+71rXNV5k8Fe8CW0NXOTp5plJsdlOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713711259; c=relaxed/simple;
	bh=FA2k7QRnmD3bpT7MWIpjwD+qj3zbuHPl5gDvpNX8x1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uHtIiGzO8nSoD6VmJN5gXof9ux9LlVaAbgJEgEWSOgMXozMKM23IeZvkrbbN6k9YFHJ17W+b7nRfJUoBolcTr8BB4k1sqy7W0u83mOjzRXigu3IsIB5UAe4wboLLeTrArCAFNMcf1ATpKpqRWlBCVZd4vn/UK0Yx+LQrTS4eceE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRYqQRJm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 080EBC2BD11;
	Sun, 21 Apr 2024 14:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713711258;
	bh=FA2k7QRnmD3bpT7MWIpjwD+qj3zbuHPl5gDvpNX8x1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gRYqQRJmd/hIvDvxXJ9pkIz4CN3jvONiWwKrr88nU+7tViXxbK+Zy2hmQpNxZN/tS
	 YFSCmFMRRfac625GIxrwBw8w1Q1DFa94aPyNe9e5ybh8XTJ/VUpI12v5O+AN1V/9xD
	 f9lkLfan7GqFjkpReQHOWtkK7O8DIS+OeaCU6EcoQFRA7SyXtHaUokEB/3EE8Yi79W
	 YjD2v9fnMpXltuH7OJzcPBEn0g+8vQGI4P0hRe3WFDUosE0GDn5hhGLwI3gwTSb15Z
	 xqtfQG3UjSd0oHcFvIgBwVKxVZBI3bv9+z6hBLBmYu3zARbGriP36k74qRRCgYGc0k
	 LmijPQxpcCKgQ==
Date: Sun, 21 Apr 2024 17:54:14 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [PATCH net-next] MAINTAINERS: Update Mellanox website links
Message-ID: <20240421145414.GF6832@unreal>
References: <20240421143914.437810-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240421143914.437810-1-tariqt@nvidia.com>

On Sun, Apr 21, 2024 at 05:39:14PM +0300, Tariq Toukan wrote:
> From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> 
> Old mellanox.com domain is no longer functional. 

It is not true, the domain is still functional and www.mellanox.com
redirects to https://www.nvidia.com/en-us/networking/.

Or change all links to point to that redirect or leave old links as is.
And I'm not sure that this patch makes any difference for mlx4.

Thanks


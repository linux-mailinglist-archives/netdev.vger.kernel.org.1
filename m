Return-Path: <netdev+bounces-105263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E11A9104A1
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 14:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B017B241AA
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 12:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9801ACE67;
	Thu, 20 Jun 2024 12:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JpGKDZj0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6575A46BF;
	Thu, 20 Jun 2024 12:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718888093; cv=none; b=Yo5Rjv4NR93/nvZtlRfau941zY3LJWHWyeOsgBFqkO2qskjhwZ1jbjkE6y8fIG/WeohK9GQ8F+y/C0qmymKWjQPcypmqNkxUa3G3DKDlieslqMRXdaSH/6d2Px/m6IUZxXy81rRp3rvw6fHSxq5hkNrQz8cgNDmUkThvUVSCzgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718888093; c=relaxed/simple;
	bh=XxOGHy5sn3zZ32+a9hXAFXf9fhelQMqz0kS5bb7MRmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X9fmmeNLafWwtPho2fRYVDpm5d6VvhnVeSpj/gY+YuN7XN/k3NPG97sSf0EdJIon3kxVJI6tZut1Cn6xmLGLssrFEcR1x5M29JRMJ+HEFtH2xD0SSXffubz9LSdXqou2SnKA9up55zh9snIBsG34ZwkS9Kcwg02EcF4yRJOV0ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JpGKDZj0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D651CC4AF0F;
	Thu, 20 Jun 2024 12:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718888092;
	bh=XxOGHy5sn3zZ32+a9hXAFXf9fhelQMqz0kS5bb7MRmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JpGKDZj0/FGv6QHMrTOsHcvcOWhgn2OST2EVZa6bHHLFIKcC96n4A54LM5dZJMAfY
	 KIzSPsx0C5XbiuHIm0HCQFZ8okNYirDmpkBqot6H8zqNpuG7gerhxbaMilxcDqIAXs
	 WTCOc3Lanl4T4Y4+yWmXgTWI8S+moi26C97KRGvPnNYdcC3wrze9LLiy7pAzS3UV/M
	 GE+CBMtyF0lMV/93tX7/r8A7PSVdSZ4FxY0ehi+1qYAs747TrX6rSrjpjzhpCJ2cWZ
	 nqQgCy12Q+Tn5JP0xe4rJm3YS0WABSv9sCGg7JOaSemK8unfDjEg6TyHVOHegjHXki
	 0zJz7BXBnzXRQ==
Date: Thu, 20 Jun 2024 13:54:48 +0100
From: Simon Horman <horms@kernel.org>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
Subject: Re: [net-next PATCH v5 06/10] octeontx2-pf: Get VF stats via
 representor
Message-ID: <20240620125448.GF959333@kernel.org>
References: <20240611162213.22213-1-gakula@marvell.com>
 <20240611162213.22213-7-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611162213.22213-7-gakula@marvell.com>

On Tue, Jun 11, 2024 at 09:52:09PM +0530, Geetha sowjanya wrote:
> This patch add support to export VF port statistics via representor
> netdev. Defines new mbox "NIX_LF_STATS" to fetch VF hw stats.
> 
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>



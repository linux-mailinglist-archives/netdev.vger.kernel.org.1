Return-Path: <netdev+bounces-181332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7FAA847F5
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 17:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99973464104
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 15:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854511E5711;
	Thu, 10 Apr 2025 15:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQLDv9fw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFDA1CB31D
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 15:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744299043; cv=none; b=CHeIdVl/n1p3nQSwVU4PlEZheOj7LKhCeofLjlEZx4JmiSPEBo3fDLHNqWxtEjOnIbFm2WB+CNkeIBnQI/rGYfta61ISUSEp2FhRK+6ZjIMh4eulxG0r1o/lCO2hkDs3ML8xkvUOEjJCV9OTSVCQT8zL2Jza0BWOsllwpoU+gpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744299043; c=relaxed/simple;
	bh=5zcV/CG8AMLAy9luku1LD5mAKplEIFPVlXKn8cKy+bQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJFaoid6lViliUBpJobbWHf9yyy1tiyskSvkdHmPtvyW8bu3NzV/UFLXTkKJRBWk/qq8Qhfh5zQCkAkTPgOtN9bpXyjKfv262+DEk5Ty43wf5OVtOjXa+rbI/mxqJc8xDQx6ZFY1t7/zl29vJipQHViweKxqF8jZs1FeedPxuvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQLDv9fw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22F3DC4CEDD;
	Thu, 10 Apr 2025 15:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744299042;
	bh=5zcV/CG8AMLAy9luku1LD5mAKplEIFPVlXKn8cKy+bQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sQLDv9fwNtDQlftYK63Xa1crTz3K3Nb0427ADYfWdru0Tigrvr36sJaABKHPdTC71
	 hAp8Y5dINwauilTu0E+12AsgghiralaNUR0SqRMla/1XR/Ktnr2GgVfjGCjXazY6Xq
	 Y7M4I6Nt3PGeHCu7f682d50yN1rMzvvC3ahQQOn5VdhdpUM0FtdCTKwDoc5AI4J5+d
	 eL4wHuU93NEBJxoRY5BTPkGCUTnuAAUG8EffgU3+4o+wsHrcZiu+yQ25ZPtJD+Txap
	 N804kSYEPBb14q0T8oF6BfXE0OW1ni0A27NHMAVJn2HBYw5X2aNpf4LTyXG9AUtlK8
	 VnQbMhmImmIGA==
Date: Thu, 10 Apr 2025 16:30:38 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: airoha: Add matchall filter offload support
Message-ID: <20250410153038.GT395307@horms.kernel.org>
References: <20250407-airoha-hw-rx-ratelimit-v1-1-917d092d56fd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407-airoha-hw-rx-ratelimit-v1-1-917d092d56fd@kernel.org>

On Mon, Apr 07, 2025 at 09:59:04PM +0200, Lorenzo Bianconi wrote:
> Introduce tc matchall filter offload support in airoha_eth driver.
> Matchall hw filter is used to implement hw rate policing via tc action
> police:
> 
> $tc qdisc add dev eth0 handle ffff: ingress
> $tc filter add dev eth0 parent ffff: matchall action police \
>  rate 100mbit burst 1000k drop
> 
> Curennet implementation supports just drop/accept as exceed/notexceed

nit: Current

> actions. Moreover, rate and burst are the only supported configuration
> parameters.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

...


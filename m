Return-Path: <netdev+bounces-142592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7C49BFB42
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 02:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00DC7283A77
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 01:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8264A33;
	Thu,  7 Nov 2024 01:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pr4TeLC6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF4714A85;
	Thu,  7 Nov 2024 01:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730942299; cv=none; b=foOW6Qc4EkMone5UjtAgIWe0Fcv7Ob51EV6H0NqUrg7cbdrZVhzssbEwnSQRSRgfVeCcs6XNqOa62rUiwt6PkWMWs8Y5A0lGFGoYDt79qiSMh9rcpXtG24RUQrMpBpy87Ps2tpGACS4yTf/LAGUcCkYL1+0pi9nHGf6iBDLggdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730942299; c=relaxed/simple;
	bh=2WGhUL3zHxIt2Ajp3s/4Md6bHmoTMKZIldbExqa92B8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fuZ6aeR92ByZ9+o+y5yb1F41HMarKNH+f02dEEugF7Lk3Aiu8NHTrgLIp1+QffzXzo4JxMB5KF9/IJhFhaBOFNn4b+ZJky1bxlvapvGSRVdyVxdHmIzjkFkWe7fBzQzIouVCt3VFu6CoMsmnNurLf9SE0n2McXsNUvrA/VCZkjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pr4TeLC6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1978C4CEC6;
	Thu,  7 Nov 2024 01:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730942299;
	bh=2WGhUL3zHxIt2Ajp3s/4Md6bHmoTMKZIldbExqa92B8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pr4TeLC6WS7ddzmEA9UXp9Qr4EXDphHbUqknJjurGpOoYtjKk8G3ihTERMZYwrylH
	 kn9r/sLo5PtHt4vqXrJvXIUIRvM55u0RSnjZoNcybIk6sV3uZKUbNbd3uqDWnLVohV
	 apiwvUyh7ITl2m591PjCG5b40/Xhjudpbu3BPHRWVM4dAhi50WDvOUjdWqn6eJKb7U
	 mtvh932JefWkOD1OxH20iQTS6XWoLgJqeFuZ2DwECfZ/adqzLeWb5+0CD2xjj9h9qL
	 RnuUZv/q17ofn1NV93U91fjsMdOW/WqVqG9/gxkl+eWie/nbBQ64HTZ/PeWwSb2k8K
	 i/tHUk/JKrLBw==
Date: Wed, 6 Nov 2024 17:18:17 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: MoYuanhao <moyuanhao3676@163.com>, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, linux-kernel@vger.kernel.org, martineau@kernel.org,
 geliang@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org
Subject: Re: [PATCH] mptcp: remove the redundant assignment of
 'new_ctx->tcp_sock' in subflow_ulp_clone()
Message-ID: <20241106171817.4903bf94@kernel.org>
In-Reply-To: <9b265c9b-f101-4ea3-83b6-7709e8f2ea47@kernel.org>
References: <20241106071035.2591-1-moyuanhao3676@163.com>
	<9b265c9b-f101-4ea3-83b6-7709e8f2ea47@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Nov 2024 16:41:10 +0100 Matthieu Baerts wrote:
> @Netdev maintainers: is it OK for you to apply this small patch in
> net-next directly?

Too soon for me to take it right now but yes.


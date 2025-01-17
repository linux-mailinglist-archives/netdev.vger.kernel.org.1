Return-Path: <netdev+bounces-159394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45703A1566D
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 19:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 570943A91F5
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 18:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE571A7253;
	Fri, 17 Jan 2025 18:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nnBi7SDv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619A71A4E98;
	Fri, 17 Jan 2025 18:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737138079; cv=none; b=oTul3KnS6ogmZrkMu9XJMb2mSWm7lP38uOrdXWHQziMuaRCls5wyu6k37bk/+JbdJQQrWWEUwXdbr8znr6musz1PREJBVHPaXEAm9BKogMZLuOX3umV7j4xDVwquOQkZ8lnl+l5vVpWdp4Q/TVpkAj/Ov7CHL/hQ3RBj9gSXIwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737138079; c=relaxed/simple;
	bh=5NV+bwcPH/oEa7AH9WICiJOBOWfffOReFm07oq6sqtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kfs9grs5jnsfnlEG2QtRvdmkCX/NCLDko0wN2m8wNcEpMZXq1NNEp8/LMK8SXVV/9cUoIgV4g76AYexxy/zYXqKdXVYBbeDAqH8TKsUCOaKFEvGzsVfhI9WBLlamKS1oLgqvlJP15NxhusOHUTefEsH9uOurk7SW+2pvogttwB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nnBi7SDv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 598ACC4CEDD;
	Fri, 17 Jan 2025 18:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737138078;
	bh=5NV+bwcPH/oEa7AH9WICiJOBOWfffOReFm07oq6sqtU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nnBi7SDv9JNDMSfyGqE/WIPcHFeYf7/bDmp0/6RVkVQQ/tTvjJUN9wqLx9sXfqn8u
	 Je8s8sN2Gvm811ALNxja32HMe5WxPF7vbwZ6ziftfQgc0Mto4lCdyZJFB6Pk1CiPZb
	 QFMl8fVB3g3LzlTj2ILQweCD6r1upecx4n5tUUsLLaofQLitk43NtrVGOzhNZERuoY
	 tn1gBKezvpiCoywfQX/FgjXmsibt5MQBD10Qf+6lJSuko8PRoNBZlkLYRnwkG049Ub
	 Ivr1pesEqgqYyhq8TzSSob6YlmxJIl/kfd2wUYttnjSRkHMxAWWDUkemddkl4r4BG3
	 /kuWT6/az/ZTg==
Date: Fri, 17 Jan 2025 18:21:15 +0000
From: Simon Horman <horms@kernel.org>
To: Denis Kirjanov <kirjanov@gmail.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] sysctl net: Remove macro checks for
 CONFIG_SYSCTL
Message-ID: <20250117182115.GU6206@kernel.org>
References: <20250117124136.16810-1-kirjanov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117124136.16810-1-kirjanov@gmail.com>

On Fri, Jan 17, 2025 at 03:41:36PM +0300, Denis Kirjanov wrote:
> Since dccp and llc makefiles already check sysctl code
> compilation witn xxx-$(CONFIG_SYSCTL)

nit: with

> we can drop the checks
> 
> Signed-off-by: Denis Kirjanov <kirjanov@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>



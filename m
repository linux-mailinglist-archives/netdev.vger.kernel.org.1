Return-Path: <netdev+bounces-235497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A0CC3196F
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 15:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A22D3A3274
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 14:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99E132D425;
	Tue,  4 Nov 2025 14:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDdPIO/d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D5130AAB6;
	Tue,  4 Nov 2025 14:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762267240; cv=none; b=a6wmY2GWKxsMO6AHpsMy6Ov1Ly+Qp77D0z+Let0P1L0SivqiI30L4u1mUOSO+Pz/zMMIYa9J++Vlfz/tTqRTTzT4t/cvoF0K5uozNq8DnznuSeOfvlmqk3b/ltsCqj8uWM+o2hJ658Bg6nT4w6HLBWS+V5MQR6TMb/ZpXrkplsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762267240; c=relaxed/simple;
	bh=cpZ4Yt5fJQhUXtSstkvHE+lAcxd35irLk0s4/MGgoTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZhBAM2J/kHgZUkl5HfAZWfS5U7k6+Q8wdBTWnEtnzA37YNpbvtg0WErZ6B4OhXkYvnlNJZuM+McP0RA0cHFq44iQ7Rk82wjpBYMBfElgaD0smRD3kxzgjV42Rk02JSXjBIoYGEhSx6wSnWFO3GAwTjfLqvVHblMjurhngNtiQwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DDdPIO/d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE8CC4CEF7;
	Tue,  4 Nov 2025 14:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762267240;
	bh=cpZ4Yt5fJQhUXtSstkvHE+lAcxd35irLk0s4/MGgoTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DDdPIO/dOAIq2I8yU/rwukj3/H9uva1XA/a0AzYDeIkzsc5cw4maVIXCNkCwFRp8v
	 fw6nLzD+DBMmwYnxUD0vlNirbNiFMZK4ITkouIDn1JayGyZGwHZlxo8hZZwm7EGdOT
	 X2Qlqo0KiAHZQ/jxMw9c/VIt1mi7J0Wfl3P1HaNzcF+kGC9/anO91JDiqxU9drnLya
	 XVabhDAbcS+sGw9NKa1mTUdVs9jO2UajQ+w7mqLaDETGuI1w9FnsozHVxBeSG4388e
	 o/aJ0j9fgtj1kd9x2jMWHDUpAaie4Zg0k46s9Us4ka1f56QlYjTB9e+GGOg7CEuUOB
	 iddwDqi4/U3eg==
Date: Tue, 4 Nov 2025 14:40:36 +0000
From: Simon Horman <horms@kernel.org>
To: Chu Guangqing <chuguangqing@inspur.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: sungem_phy: Fix a typo error in sungem_phy
Message-ID: <aQoQZFUXupfJI1nA@horms.kernel.org>
References: <20251103054443.2878-1-chuguangqing@inspur.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103054443.2878-1-chuguangqing@inspur.com>

On Mon, Nov 03, 2025 at 01:44:43PM +0800, Chu Guangqing wrote:
> Fix a spelling mistakes for regularly
> 
> Signed-off-by: Chu Guangqing <chuguangqing@inspur.com>
> ---
>  drivers/net/sungem_phy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks,

I see that with this change this file is now codespell-clean.

Reviewed-by: Simon Horman <horms@kernel.org>

...


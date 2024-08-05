Return-Path: <netdev+bounces-115840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58707947F8D
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 18:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E6941F235AE
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 16:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEA715C146;
	Mon,  5 Aug 2024 16:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="utcxyWms"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A491547E7;
	Mon,  5 Aug 2024 16:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722876347; cv=none; b=LssGl0hP/YKZP+o7PFzCm4HZGlQJyAZvpYo/PSXR/C6fpbRHVFQTcsorzKHl6k8nplqnWuhT82dWRmcPyPy5NTG1T2r9jaa7+c+xDPATzZvUWaIxBtb8wFGQy43qs5Jm+I+21UZgf4tmrb34Jbd3/xRLLFR+BmNSVnAa+e4vmo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722876347; c=relaxed/simple;
	bh=26RdvaSTj/TLBYMyGJi/WjjDOj+f+vioOGEuWpEo9Wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hDHbaMyeCJZfps64xdvr/Z65Wl3+bDvMkt8BfrTP6WHfd4RYIwrIF+lMPDgLOEggO2b+NNFSYV8KaykNac9xmz/v5dcGV56e/zowSq8N3QV8cPSCounBSQqzI9JTUCzkSeDtH/bv7k4PhZ5TJzpGS6c+uQNw+4bdeEVM64r0y2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=utcxyWms; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B95C32782;
	Mon,  5 Aug 2024 16:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722876346;
	bh=26RdvaSTj/TLBYMyGJi/WjjDOj+f+vioOGEuWpEo9Wk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=utcxyWmsNMJx26OShO80X/NAFJKxHTUCe8BSPuoI15R6VNT8OHIvkGr4mN1WU9inn
	 mYLUkrnwggiFrTbYBj7TCoSRwS5KrgbAdSXA31A9KOlvDY2fJ8KEnNqlkad9kZQZ1e
	 3doFdpll7up9P4jOzNU9l6ePJ7DUeM1z8WRUQv3n1kVMOLhAPvSl2jPhYarp1sOwQM
	 REZugAp56JGZm3ivJbAzcJHAymO4htynGZHrFnqhNtonmDQWbrpUOzi5FMRYmR3ffU
	 SUK4C6SMzHidGKTgTH4fHKQ95OSRbdS332v4SHaYVtvduGLb3pkPeieajs0EtNa5mk
	 4/e18xHTXlraQ==
Date: Mon, 5 Aug 2024 17:45:43 +0100
From: Simon Horman <horms@kernel.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v2] net/chelsio/libcxgb: Add __percpu annotations to
 libcxgb_ppm.c
Message-ID: <20240805164543.GL2636630@kernel.org>
References: <20240804154635.4249-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240804154635.4249-1-ubizjak@gmail.com>

On Sun, Aug 04, 2024 at 05:46:09PM +0200, Uros Bizjak wrote:
> Compiling libcxgb_ppm.c results in several sparse warnings:
> 
> libcxgb_ppm.c:368:15: warning: incorrect type in assignment (different address spaces)
> libcxgb_ppm.c:368:15:    expected struct cxgbi_ppm_pool *pools
> libcxgb_ppm.c:368:15:    got void [noderef] __percpu *_res
> libcxgb_ppm.c:374:48: warning: incorrect type in initializer (different address spaces)
> libcxgb_ppm.c:374:48:    expected void const [noderef] __percpu *__vpp_verify
> libcxgb_ppm.c:374:48:    got struct cxgbi_ppm_pool *
> libcxgb_ppm.c:484:19: warning: incorrect type in assignment (different address spaces)
> libcxgb_ppm.c:484:19:    expected struct cxgbi_ppm_pool [noderef] __percpu *pool
> libcxgb_ppm.c:484:19:    got struct cxgbi_ppm_pool *[assigned] pool
> libcxgb_ppm.c:511:21: warning: incorrect type in argument 1 (different address spaces)
> libcxgb_ppm.c:511:21:    expected void [noderef] __percpu *__pdata
> libcxgb_ppm.c:511:21:    got struct cxgbi_ppm_pool *[assigned] pool
> 
> Add __percpu annotation to *pools and *pool percpu pointers and to
> ppm_alloc_cpu_pool() function that returns percpu pointer to fix
> these warnings.
> 
> Compile tested only, but there is no difference in the resulting object file.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> ---
> v2: Limit source to less than 80 columns wide.

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>



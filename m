Return-Path: <netdev+bounces-180385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C147AA812A4
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 18:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9E294E17FE
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 16:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A4222FAD4;
	Tue,  8 Apr 2025 16:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vh+pb+U1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145D6158DD8
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 16:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744130592; cv=none; b=HuvZH+omeQQy4qYtvU/WWrgOilXUW0920VgArNayVCjqYJ0qIbNAi/MDKscQpASVZw3e/+yj3PNhu0gr4qyVzEInUFFS48/rXVnIp+61tnZZQI1/mGCNOxP30B+oytLK+Ag1lfq+ArFGf+3c6Pa5lCx2ijFRHC2WAN8V3dgj8Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744130592; c=relaxed/simple;
	bh=fxNUHxxR8led9u3bUVvKny/aFMYNK49ZdxJkONGKt0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P69irBnj/htcFvfb0yE28n29xLG4ye4gY9a81X4StXtE8nlwi7+eqRU4GSf5wmqWjXH0Q2Qro+wR7sNL7R/SorHiemkCLilz758ihU45UZ34gNYQOvU4qrnmGuq3OYc8VugjoGqD+1K7BcXiYXzB7sP8RNfVp0AM+VBO0zHTFw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vh+pb+U1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E89C4CEEC;
	Tue,  8 Apr 2025 16:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744130591;
	bh=fxNUHxxR8led9u3bUVvKny/aFMYNK49ZdxJkONGKt0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vh+pb+U1zf4f/O6N1EfOG+wNCKzHx1HhQmFQkAHUYwXOlveu/Lw3+ZEbVAOIoZ4Zv
	 gJ14o+djPKel5w8n+NoVLN/Tu14PYgIkHTF0cfyg1xMut0iKLBnyeTWuW+eTp2gqa7
	 cNSVxxA9WSGXQOJZUESXDRfF34w5qIM5FcShppmwWXYrRJSiWqXMaJjbRLBcE8VBA0
	 D80s4BeNi0MUsWIgXw1/STQTauQmCFxDWOhvdTJtaZI6ZsAzq2CyPQ3RO42RJxj4pN
	 J7z5aH6jPoKKjmUYpFO/8scp75Z8mWZ9vsXLDsUsN0pcgexZvVMTaodn68fHQSTHOF
	 mfWu2kyZ9zXKg==
Date: Tue, 8 Apr 2025 17:43:06 +0100
From: Simon Horman <horms@kernel.org>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, suhui@nfschina.com, sanman.p211993@gmail.com,
	vadim.fedorenko@linux.dev, kalesh-anakkur.purayil@broadcom.com,
	kernel-team@meta.com
Subject: Re: [PATCH net-next 4/5] eth: fbnic: add support for TMI stats
Message-ID: <20250408164306.GD395307@horms.kernel.org>
References: <20250407172151.3802893-1-mohsin.bashr@gmail.com>
 <20250407172151.3802893-5-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407172151.3802893-5-mohsin.bashr@gmail.com>

On Mon, Apr 07, 2025 at 10:21:50AM -0700, Mohsin Bashir wrote:
> This patch add coverage for TMI stats including PTP stats and drop
> stats.
> 
> PTP stats include illegal requests, bad timestamp and good timestamps.
> The bad timestamp and illegal request counters are reported under as
> `error` via `ethtool -T` Both these counters are individually being
> reported via `ethtool -S`
> 
> The good timestamp stats are being reported as `pkts` via `ethtool -T`
> 
> ethtool -S eth0 | grep "ptp"
>      ptp_illegal_req: 0
>      ptp_good_ts: 0
>      ptp_bad_ts: 0
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>



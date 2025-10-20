Return-Path: <netdev+bounces-230895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E5240BF15E5
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 14:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 631FB347F1E
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 12:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6815E312804;
	Mon, 20 Oct 2025 12:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KSPYIoGd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E783126D6
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 12:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760964979; cv=none; b=VIX22WxS6bLiNlPRfw5UtGR5C/QlK9jtOiJ6Ri0ROuolRcT5tRFoLN10DaQ1M66mv4VqJXbXtffjQJXNxgDhqU021QC2rwrTFZPYSd+wEDOBAUWKEqorHDtGasbtiKqmFQ2EXr0G9AERoqHeSAn1LdDuwhTEBraObIEpapj4nl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760964979; c=relaxed/simple;
	bh=mB1T463Pue4zMzNYKam8u8i4j2I1kXsp/IO3Nv7JDH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u64lRbQyl1Yp79nRPqX7ZHTpVeIy1mpHBBUdPiaa8OwMLxg+QEsHWBfqK9LY+dkBe7cgdbr6e9JGnyTikjiV84MYRAre610DcWlhFgrk6HQI7pSiVBybAgah02nH0cjkxbmPPuTUMZUYHzlJjNAgYE3uyFm2/a6ecqYfVIQd9Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KSPYIoGd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 587CFC4CEF9;
	Mon, 20 Oct 2025 12:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760964978;
	bh=mB1T463Pue4zMzNYKam8u8i4j2I1kXsp/IO3Nv7JDH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KSPYIoGdLNRikdmP7hsHUXNTRbalQ+SLHGBSD55fK1vmtXhKYNs6vBWqge7RICBlC
	 y9f6GBeOwdTe7grraPX1PSOfzkww919I0my+h9gwgFumlfoe3rQtZDNEXg4bZF1YDn
	 cYTsUpvDlEWPx1zsIBwn8e6uNq+zkrCOv4HGNle+plRTN+7xqJm+HzJtOy4go8oz3H
	 5VEibPobuxYKaQ1f7snre/Z15ng1oM6PGgaVXBTuGTMAS792rb7O0wIsWtZ1myf0X3
	 PHPKtVcIIy1vmCrwkCVXBDh/Rj/yxGZicPMwRbiIdOhs5dSx5MX+WOjsbUpWP/OEk5
	 BcCHRI6p375LA==
Date: Mon, 20 Oct 2025 13:56:15 +0100
From: Simon Horman <horms@kernel.org>
To: Shi Hao <i.shihao.999@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH  net-next v2]: 3c515 : replace cleanup_module with __exit
Message-ID: <aPYxbwjIlyPHrTY3@horms.kernel.org>
References: <20251018052541.124365-1-i.shihao.999@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018052541.124365-1-i.shihao.999@gmail.com>

On Sat, Oct 18, 2025 at 10:55:41AM +0530, Shi Hao wrote:
> update old legacy cleanup_module from the file with __exit
> module as per kernel code practices and restore the #ifdef
> MODULE condition to allow successful compilation as a built
> -in driver.
> 
> The file had an old cleanup_module still in use which could
> be updated with __exit module function although its init_module
> is indeed newer however the cleanup_module was still
> using the older version of exit.
> 
> To set proper exit module function replace cleanup_module
> with __exit corkscrew_exit_module to align it to the
> kernel code consistency.
> 
> Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
> 
> ---
> 
> changes v2:
> - Restore ifdef module condition to compile as built in module
> - Adjust subject prefix from "net:ethernet" to "3c515"

Thanks for the update.
The code changes in this version look good to me.

One minor nit: the whitespace in the subject look slightly off.
There is probably no need to repost because of this.
But I would have gone for:

Subject: [PATCH net-next v2] 3c515: replace cleanup_module with __exit

But overall this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>


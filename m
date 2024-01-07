Return-Path: <netdev+bounces-62211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 159B682635A
	for <lists+netdev@lfdr.de>; Sun,  7 Jan 2024 09:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5CCB1C20BE2
	for <lists+netdev@lfdr.de>; Sun,  7 Jan 2024 08:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96ADA125D3;
	Sun,  7 Jan 2024 08:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldQ/Mzv/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDA812B60
	for <netdev@vger.kernel.org>; Sun,  7 Jan 2024 08:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 770C5C433C7;
	Sun,  7 Jan 2024 08:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704615620;
	bh=0jxvKQlviq3w2l4tjTCkl1DTCdkFpUNiQEOJlhShvtI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ldQ/Mzv/jEYhMZj6wMyzKCz7AqERMmGU27tsh84oBYexrRbTmeMYsPTfme57eGPr7
	 23WyOFmDci5i/qukwzv8MWQy3J4h0/CYykk48WeJQs7TcEa0rHQWMngUto204jLVIi
	 fcHO0a+8YEWoLSdW0BiyjE+04b7mV14eQfuftQFc9CnKbHZwILqaV7LwkcQeMBB+eR
	 rB6YyGfU6JzDeZkaCwVHT1lel9wnmbLHXHfOYQYWg/nnRhOsmnrGMyHxy+p3AM2lIn
	 WVlHbV3hEvRPxQ0Y96x13ItVzqJtycEqO3sZtcF+Ygs+kOFNZBgNavVhFPPrKxfRqq
	 2iHQMJ1ga0ZJQ==
Date: Sun, 7 Jan 2024 10:20:15 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH v2 iproute2 0/6] rdma: print related patches
Message-ID: <20240107082015.GA8078@unreal>
References: <20240104011422.26736-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104011422.26736-1-stephen@networkplumber.org>

On Wed, Jan 03, 2024 at 05:13:38PM -0800, Stephen Hemminger wrote:
> This set of patches makes rdma comman behave more like the
> other commands in iproute2 around printing flags.
> There are some other things found while looking at that code.
> 
> This version keeps similar function names to original
> 
> Stephen Hemminger (6):
>   rdma: shorten print_ lines
>   rdma: use standard flag for json
>   rdma: make pretty behave like other commands
>   rdma: make supress_errors a bit
>   rdma: add oneline flag
>   rdma: do not mix newline and json object

Hi Stephen,

We tested this series and it works correctly for us.

Thanks,
Tested-by: Leon Romanovsky <leonro@nvidia.com>


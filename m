Return-Path: <netdev+bounces-219928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C80B43B41
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 14:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C483F7B13B1
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 12:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D976F2D8376;
	Thu,  4 Sep 2025 12:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sEMNz2Xy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B463B2C21C0
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 12:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756987981; cv=none; b=bU2afonAKcJbYxQfgooRZfN24JF/zPQ4bzWhUTdknnrKCAApv9/IofyDKu1O00Y2nKmQRYRazG+mcEjfv2RCcMZ9M3QpKYfBzl7b8dHtjjV3SZ437VzWhWgibPzdnGh/ixOHLMWNmct4N0H9Fx4Bd6ArcGvPeNQiatZce54KsYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756987981; c=relaxed/simple;
	bh=s7MQq9kHkrKLjpEL3teBJNZ2sPm3Mb9ihGlhZD945gA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rhU+XKsKuzDxv3BjNJGlvJZwdbl1TL3s6ZfhD77kpTPN/RJQlyc6ziV9HQbYpHuy6FWUeN/897r0ir5hG38nsP5zTpzWHbGqkTKJkWyCGsg2WiAgZI+FrSfrX9VDkT2SAerfvKx3OyCbNnWISxhsjjfo9q30vOVEX1878+Q9oWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sEMNz2Xy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A6ABC4CEF4;
	Thu,  4 Sep 2025 12:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756987980;
	bh=s7MQq9kHkrKLjpEL3teBJNZ2sPm3Mb9ihGlhZD945gA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sEMNz2XyaMscPVArONsfmbusYzITvT523EUF625qRGpW+OLtruTquu1XHJ+mteV/p
	 6XsYEYw+UOuiTyONJPU1DMYq6aZmvxbT2RVqoWg1rOXDOijNvLH9xYriAnGwIdXI7b
	 H6tLopBfxKIPfy4+DvVtsQnZd8aL9M9FS4NUpr4nqXMmzm/OS97Z7jpN9vWBDqfFor
	 N+h1Vh8F5AzMpdeBW5Ftf/hOlxFyOopNE1ipEOtXFEVqgcv8/FDLJwNOlQl/Lwg5ln
	 q/vXmw8wrqVFKzZUYSMAQdRMUY8baSo4/FnHFVqwjFz2DVd8I47PJPP0umLGZ4ASEx
	 PvwYhojWlulqA==
Date: Thu, 4 Sep 2025 13:12:56 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, john.fastabend@gmail.com,
	sd@queasysnail.net
Subject: Re: [PATCH net] MAINTAINERS: add Sabrina to TLS maintainers
Message-ID: <20250904121256.GI372207@horms.kernel.org>
References: <20250903212054.1885058-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903212054.1885058-1-kuba@kernel.org>

On Wed, Sep 03, 2025 at 02:20:54PM -0700, Jakub Kicinski wrote:
> Sabrina has been very helpful reviewing TLS patches, fixing bugs,
> and, I believe, the last one to implement any major feature in
> the TLS code base (rekeying). Add her as a maintainer.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>



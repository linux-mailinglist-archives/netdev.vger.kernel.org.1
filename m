Return-Path: <netdev+bounces-123603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CD99658AF
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 09:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52B621F23B45
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 07:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E87B1531D3;
	Fri, 30 Aug 2024 07:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPYjqfsQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB9756440;
	Fri, 30 Aug 2024 07:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725003358; cv=none; b=WovHtwKrDqa9mNq7aEwwpRlCijxXpJccpzRFXCR65LPbz2VERpcdi7MWA3Dl+F0HyZK+0zYVdqwC933o72pbtkyN+A84Jw1iwX9d9nuRGP6dQO8lS0Sh4jz154qczm5XtzjL8LPhsH4PcCAu3RufaHfL1jj7spDRqd4DpMOtaQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725003358; c=relaxed/simple;
	bh=3riHkqm7T5xycD0sgr32Z0W0i2hevSL56eCchx+6aVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kbPMFUE91G9hltrS1ijw0af1M7DPzOzgJ9WvFA/LUmQaVwuKgqDgwGPxQlyoOitx2P8XvTGpTKWpU3bptELWb5V8Ja0GuEXSN5RJgHHlrTW0V57ogXLLPA0ofy0Pg5TILMNjOQv7q6NAmq+/lhFb/Uf25Fcqpmrjjiy0lCQHhf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aPYjqfsQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEEFAC4CEC2;
	Fri, 30 Aug 2024 07:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725003357;
	bh=3riHkqm7T5xycD0sgr32Z0W0i2hevSL56eCchx+6aVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aPYjqfsQ34ZRztvg8zIby9zuR/dG3AQH1phKWiee4tYgpZyACWIp6lIG9UDYxPMOp
	 b6kMB3kCUYv4j1SnJQus/8+QBodYoL5tdhZx1FJ92aLwWoknwckptKYJVIHYjZcNbx
	 COX0+C8NxgPMGdPGY1q72y39bx+95vJt0R490nBXBIPmiL5IQEx6AuM8y1in2zjl+D
	 ECb90V7AzsvDbYcZifRNb4K9h3kj/wNAjK2wG63IkFEQ8YNzLPZv8TLy/p589RMMez
	 wHzXQlcjq5kXKAuyCgYDI6YtiBvdEV5u0F7jdltdfSKeMoXIFNZI1ucTOYGjJ9m7kX
	 rrItCZli0N5kw==
Date: Fri, 30 Aug 2024 08:35:53 +0100
From: Simon Horman <horms@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: bharat@chelsio.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] cxgb4: Remove unused declarations
Message-ID: <20240830073553.GF1368797@kernel.org>
References: <20240829123707.2276148-1-yuehaibing@huawei.com>
 <20240829123707.2276148-3-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829123707.2276148-3-yuehaibing@huawei.com>

On Thu, Aug 29, 2024 at 08:37:06PM +0800, Yue Haibing wrote:
> Commit e2d14b42c25c ("cxgb4: Remove WOL get/set ethtool support") removed
> t4_wol_magic_enable() and t4_wol_pat_enable() but leave declarations.
> 
> Commit 02d805dc5fe3 ("cxgb4: use new fw interface to get the VIN and smt
> index") leave behind cxgb4_tp_smt_idx().
> 
> cxgb4_dcb_set_caps() is never implemented and used since introduction in
> commit 76bcb31efc06 ("cxgb4 : Add DCBx support codebase and dcbnl_ops").
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Thanks, I agree with your analysis.

Reviewed-by: Simon Horman <horms@kernel.org>



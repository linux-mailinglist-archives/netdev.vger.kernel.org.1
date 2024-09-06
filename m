Return-Path: <netdev+bounces-125929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2F396F494
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 14:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13C20B21814
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 12:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A461CBE98;
	Fri,  6 Sep 2024 12:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iy2VYzu2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC291CB14E;
	Fri,  6 Sep 2024 12:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725626974; cv=none; b=HOdgJlcnsDMTRfl1HTiB2cHWCCN2Gg5Oh6Wb4ZBLwFvK8mh87jjkuE38hcVC/Yt61kPYaT64dHKWAa+b5c/H4yK+oluFQVZCZrcuEPtw+a/dkLRsdR3QugC7Si6ch2tYyZAiQYC6c532TeLbHIR2bNhSPGtXLIvPfua91ylP+dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725626974; c=relaxed/simple;
	bh=lncAoqxCDXvCitN6TBXMfjNZSYKKZ+uFMg+gCaNDfTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q5Gkwonb/J+Toc27/DbqBB0tKcLfPox/9CJmumIqLRKW6/YOWtNl9o0JGmIRffJdOZa1vBv4y4VU1X+griKXshkZb2OPl6rO7r/M7Hgd7dZMNkPkcBnLf8UyEBWU/3Qz3fV828Xhn1N06jd0WdIJk3YmCf6DTYoOq1w6Y/YNLJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iy2VYzu2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E7CC4CEC4;
	Fri,  6 Sep 2024 12:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725626974;
	bh=lncAoqxCDXvCitN6TBXMfjNZSYKKZ+uFMg+gCaNDfTI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iy2VYzu2pXdp/8PmaQHoWbWaav2WbV+UWoIggdJUGIIOvvHFirE+lJBBCIAm5MvNz
	 s2slPnFNH757sEczFj+rBjl3vvUYbZiKxQDmZxAB0DOkvgGWORksdS5KYDYk4pzJtJ
	 nnZRyc9yfnr7cxMG5Ivb4nHl+V488WJ9a0J0peZSYijoFGWEF6h4Zs/BjUQ8/nAY6S
	 e5tkTXscQNSsch+YIn05GdD655Iw6qEzxdlV2WLeOAB4kqcoOfrqZ2RKRkNIUs2pUV
	 f8+S8yGQGw3dwSty/8XGlCtNJGt8PSsFcsrqlX1Q5L4r2FgEU+cLcmGJpSPNbjlaVI
	 W1ylI+A/FfsKQ==
Date: Fri, 6 Sep 2024 13:49:29 +0100
From: Simon Horman <horms@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org, o.rempel@pengutronix.de,
	p.zabel@pengutronix.de
Subject: Re: [PATCHv2 net-next 2/7] net: ag71xx: add MODULE_DESCRIPTION
Message-ID: <20240906124929.GG2097826@kernel.org>
References: <20240905194938.8453-1-rosenp@gmail.com>
 <20240905194938.8453-3-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905194938.8453-3-rosenp@gmail.com>

On Thu, Sep 05, 2024 at 12:49:33PM -0700, Rosen Penev wrote:
> Now that COMPILE_TEST is enabled, it gets flagged when building with
> allmodconfig W=1 builds. Text taken from the beginning of the file.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Thanks,

This description lines-up with the one in Kconfig.

Reviewed-by: Simon Horman <horms@kernel.org>


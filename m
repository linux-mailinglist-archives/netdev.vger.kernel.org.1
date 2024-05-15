Return-Path: <netdev+bounces-96513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6258C64BE
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 12:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C2F2B24BE0
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 10:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636295A0F5;
	Wed, 15 May 2024 10:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hj0Arvb6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C30B5A0E0
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 10:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715767453; cv=none; b=U8ZFunujct0sbjK9dP6tZXYUFEWBr2hIJyE8u0cz76wTgmF54/J2x45ALxQQzapUiwcdr4UPWPk9eExs0za8BFihQX9B/d7xzv+fkvEAXTAQArl1fJScXBPm85/t4yk2bnGiuUky6rrVPN+2Vrr5hT0gYNO6XLtHOP0GJAJnDXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715767453; c=relaxed/simple;
	bh=wjArU7c5bhYx/isZkx1p/D00M3iG77OJUiOUGoOJz8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j1kbd+c/eHIVXuvz8BMOqrwwfkLWl3aRTLCgqYqm3LosMgJjvAYyUorGihJ1F7T4Ewo4m6VekTq/F5ML9SkMCRxwTP41WspqwK20hzFgThfNn0hAC0Yatw2lziPh3piBR0H2HD3J7Zzu9V6iYSdgFGrvSxh66S9XlFHMWMqwK94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hj0Arvb6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E13C32781;
	Wed, 15 May 2024 10:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715767453;
	bh=wjArU7c5bhYx/isZkx1p/D00M3iG77OJUiOUGoOJz8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hj0Arvb6BZHh0Z33RhssFecOD7cJ4ZZdtYpPSUnOWod0qjPXaxaQm/fm52uZdf7nF
	 NH+fXmqKYUBHd770c4/1/xgstnDry7OH2FEH/0tyRmYDQKzBzpcFTU6YWdsBApJgZI
	 6SkIGvTQoLewrDQpxERFGVziXyo6GpF8sYHXD/DHd+Y6MUByuGR9H0mlRn5lQ5ggfC
	 mxhBVGqBdiPvHs39E9b+JUDD4cCTzJOiFKBdilqXmn32tAAbK3p/8CcdvvkLaoxOm3
	 7YMAh2KWn7oh5Wp5zj1Q081aR74FgxCReQjYTpX75L0AocVy7oWkCkZz7KMfAGJSVr
	 PgCDrJPFkrmiQ==
Date: Wed, 15 May 2024 11:04:09 +0100
From: Simon Horman <horms@kernel.org>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: netdev@vger.kernel.org, Roger Quadros <rogerq@kernel.org>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Chintan Vankar <c-vankar@ti.com>
Subject: Re: [PATCH 1/2] net: ethernet: ti: am65-cpsw-nuss: rename phy_node
 -> port_np
Message-ID: <20240515100409.GD154012@kernel.org>
References: <20240514122232.662060-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514122232.662060-1-alexander.sverdlin@siemens.com>

On Tue, May 14, 2024 at 02:22:27PM +0200, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> Rename phy_node to port_np to better reflect what it actually is,
> because the new phylink API takes netdev node (or DSA port node),
> and resolves the phandle internally.
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>

Hi Alexander,

Thanks for your patches. A few minor notes on process:

1. Please provide a cover letter when posting Networking patch-sets
   with more than 1 patch.

2. As an enhancement - as opposed to a fix - this patch should be
   targeted at the net-next kernel. And it's best to explicitly note that
   in the subject.

	Subject: [PATCH net-next] ...

3. As it happens, net-next is currently closed for the v6.10 merge window.
   Please consider reposting as a PATCH once net-next re-opens, after 27th May.

   In the meantime, feel free to post new versions as you get feedback,
   but please switch to posting as RFC during that time.

Link: https://docs.kernel.org/process/maintainer-netdev.html

-- 
pw-bot: defer


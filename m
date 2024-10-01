Return-Path: <netdev+bounces-131079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF40B98C83B
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 00:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E136B1C22420
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 22:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A421BDABD;
	Tue,  1 Oct 2024 22:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uprt/v/d"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC53919D06B;
	Tue,  1 Oct 2024 22:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727821814; cv=none; b=JVdUgcbBC7E8ZUajDg+2gdb86VkbmCFnUm//4xnRgH0S+Id0p/RNBkWiGmYbt58MSmgTIpGusPEag+MytaPZEPr3YRZev1i9XAzt6/K9hg1ha7tDe3Zwvmku6gvi0NuzzdnqqGBX0OgUBi8H6sw5M7YU50/ep19+KgDLERdAASs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727821814; c=relaxed/simple;
	bh=8Hr2Zc1+HZUTNy+gg+IW0y36N15lGUVXYx8RaCAhjg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cgKWHPMbTnKJivEYAHG9FhRGKrwbv8vKDd6Sn2PkR3iFm8HYaJrwI7rUVlhb0I7V0vIKUByYiV596lw3102OUzHOzOr6q4O6WyBqZS5xoMJmK8M9NHOsZ7CCUZ3X07nGESc19lG+2XB3YZafco9e0PMPhxu8JTGrMXa3Tab3CRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=uprt/v/d; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DLnnfAtWrhihGro3Zy0uuGDMEk7itqCfLq7weDw0K9o=; b=uprt/v/dH/8MivUWT2fg6q3ApB
	pa/dz98nHPMmnSZcAWIrMVNTYvx38rYUd5Ul3KFkBYCGkZGPjqgcjhbPwrFWFLgXY8tRZlDdJTZxP
	oBUENO213AN+Ssjt9M4wFCv/vBk+stCnvEn0DPt9RTwHnVmWT6sma3Jk1i81YBjN49mc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1svlNd-008mXc-7L; Wed, 02 Oct 2024 00:30:05 +0200
Date: Wed, 2 Oct 2024 00:30:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	steve.glendinning@shawell.net
Subject: Re: [PATCHv2 net-next 5/9] net: smsc911x: use devm for
 register_netdev
Message-ID: <67c2001c-59f5-45ac-b5fa-89745baefac5@lunn.ch>
References: <20241001182916.122259-1-rosenp@gmail.com>
 <20241001182916.122259-6-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001182916.122259-6-rosenp@gmail.com>

On Tue, Oct 01, 2024 at 11:29:12AM -0700, Rosen Penev wrote:
> No need to call in _remove.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew



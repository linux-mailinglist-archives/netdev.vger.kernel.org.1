Return-Path: <netdev+bounces-247849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FB2CFF839
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 19:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B36A324DA4D
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 17:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D90B34A3AC;
	Wed,  7 Jan 2026 17:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="utRdtkD7"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3093A0B21
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 17:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767807808; cv=none; b=ZAfpJSNgK68rZDhFyQMtaQEdzT4n0xIulDejWgVX9sy6zfuh1Jgicm/2UzDiBt/tkjS9wxwRPjhch4FQlilM1LLqEm9RzefjPC7Y7P+brPToz3bwSZS8a8sAOB/J+MnjVlEPwjgreYMSdswTXQx6w7wExiGj02WwUc7VWEY1/Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767807808; c=relaxed/simple;
	bh=V95J9fNee3+Dx8FXgV4XIKi03wV1Wd5CaNJUONYkaNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g+GOrBjVv0+J9wVbn2uN568BlGaI2jDX+MXRPT2CvQMl7+mgE4FpZ+y6SxcJD+Z9XvQsBYY4OF0ybQuTZXnZUXxC1L4A2g0TGauE4OPnjimCALkRsgRcLP2+BP6SO9g9wm/dhwzzo5UFMdxfKRHRoA7G+RvhyFTvnI6FyYETEqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=utRdtkD7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xnpEUpxzZmn7Lue4zFPJYF4CnKz+QaMHPZS6tOsK1S4=; b=utRdtkD7CFkn728PEefjQGuPpz
	ivK3seEjARHWdKkAUyE7Lbcfolvp5Glc/bdy1Kt5r8Y9Ye/jSvyU/zX6rLw586gxWqlChKG717p7I
	zF6LZBDNQ36agD3GK2LWKtICAZRmOQtfxtunim1+LHxTJrmMk7L6gAkcUSrO2zvO9PPA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vdXZ0-001py9-Se; Wed, 07 Jan 2026 18:43:18 +0100
Date: Wed, 7 Jan 2026 18:43:18 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next] epic100: remove module version and switch to
 module_pci_driver
Message-ID: <5e0d2d79-e3ee-4d1e-90b0-d83249354abe@lunn.ch>
References: <20260107071015.29914-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107071015.29914-1-enelsonmoore@gmail.com>

On Tue, Jan 06, 2026 at 11:10:13PM -0800, Ethan Nelson-Moore wrote:
> The module version is useless, and the only thing the epic_init routine
> did besides pci_register_driver was to print the version.

Hi Ethan

The threading is a bit odd in these series. Generally, for a patch
series, each patch is numbered, 1/3, 2/3, 3/3 etc. And it is a good
idea to have a 0/3 explaining the big picture of what the series does.

     Andrew


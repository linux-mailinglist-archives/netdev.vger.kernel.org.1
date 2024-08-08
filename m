Return-Path: <netdev+bounces-116752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F1B94B982
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 11:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E42B282B9A
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 09:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B561898E1;
	Thu,  8 Aug 2024 09:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTQv1zwO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028A184DF1
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 09:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723108394; cv=none; b=NHNdfn+3Op4lrkHlb6tMU4CHuXek4wwbvK9WKDsKXBbo3FEtWNf33ZdF3RRujnYmzzb0TR+hgvYIF8grYD2UVs9Omx/rYk17HMMDeFKcQZAgU7DRnATlaxJDw3mgpT73B5zgZeTrLube7Uz/DsVaB7vSn8Wr1gopPflcR/2oATk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723108394; c=relaxed/simple;
	bh=lfGCWziQmTXbafbuX+UYpXVp1VnfckN0oeWBv1XTfTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rB6SUes2UqXBOMC9qljdjC8Gbp+g0YcvcTVs0KoMCgxDrmzNj6gPFgZwq3WDqRkO48XNpBgRXUomL2ozaATjjpraBep1YqBEnICaLF2s/9RWcdKey4zy9CFe+ik5bklVX9A03FVz/c+m7zSaPxvfunnsPFXr0AdjOd1JTIGA0Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PTQv1zwO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0422C32782;
	Thu,  8 Aug 2024 09:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723108393;
	bh=lfGCWziQmTXbafbuX+UYpXVp1VnfckN0oeWBv1XTfTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PTQv1zwOvCYGHr8KqXsVDcUTNzy4C0vg5uVJgjPKFDYc4/6xrT76dtTq9EztIcQNG
	 b/yE6NfBcdENza4Ay0JEVffv7SjmagadXlazU0zEZmBFDriTDbucB/UJIxMsy+nJnP
	 o1EBqMgQM42cb78AIR2iTHTPFzvF3IEj4TH2WVKQFzqwVYxCYGfuu5KqhqmP+Y33it
	 m2fJAzu4wn8Aw81+PUBa/hq96k4M8EiUHsnFCZXb4YhXoEAEeEukd8VU7qvr92c+a+
	 1V70eBHWp3pCsjSGcvobR5UyxEuQnxzCuvveu6pM6WGIsaYUEul6wZEiYlc0Gp6sNX
	 VX8RhcLs7FVkA==
Date: Thu, 8 Aug 2024 10:13:09 +0100
From: Simon Horman <horms@kernel.org>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net v2 2/2] docs: ABI: update OCP TimeCard sysfs entries
Message-ID: <20240808091309.GF3006561@kernel.org>
References: <20240805220500.1808797-1-vadfed@meta.com>
 <20240805220500.1808797-2-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805220500.1808797-2-vadfed@meta.com>

On Mon, Aug 05, 2024 at 03:05:00PM -0700, Vadim Fedorenko wrote:
> Update documentation according to the changes in the driver.
> 
> New attributes group tty is exposed and ttyGNSS, ttyGNSS2, ttyMAC and
> ttyNMEA are moved to this gruop. Also, these attributes are no more

nit: group

     Flagged by checkpatch --codespell

> links to the devices but rather simple text files containing names of
> tty devices.
> 
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>

...

